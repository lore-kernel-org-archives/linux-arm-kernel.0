From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 19:23:50 +0800
Subject: [PATCH] usb: otg-fsm: Cancel HNP polling work when not used
In-Reply-To: <AM4PR04MB2130070189E9465A354B69D689230@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <20160628011827.1688-1-stephen.boyd@linaro.org>
 <20160629094347.GL25236@shlinux2>
 <AM4PR04MB2130070189E9465A354B69D689230@AM4PR04MB2130.eurprd04.prod.outlook.com>
Message-ID: <20160629112350.GM25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 10:56:42AM +0000, Jun Li wrote:
> > >  }
> > >
> > > +static void otg_stop_hnp_polling(struct otg_fsm *fsm) {
> > > +	/*
> > > +	 * The memory of host_req_flag should be allocated by
> > > +	 * controller driver, otherwise, hnp polling is not started.
> > > +	 */
> > > +	if (!fsm->host_req_flag)
> > > +		return;
> > > +
> > > +	cancel_delayed_work_sync(&fsm->hnp_polling_work);
> > > +}
> > > +
> > >  /* Called when leaving a state.  Do state clean up jobs here */
> > > static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state
> > > old_state)  { @@ -84,6 +96,7 @@ static void otg_leave_state(struct
> > > otg_fsm *fsm, enum usb_otg_state old_state)
> > >  		fsm->b_ase0_brst_tmout = 0;
> > >  		break;
> > >  	case OTG_STATE_B_HOST:
> > > +		otg_stop_hnp_polling(fsm);
> > >  		break;
> > >  	case OTG_STATE_A_IDLE:
> > >  		fsm->adp_prb = 0;
> > > @@ -97,6 +110,7 @@ static void otg_leave_state(struct otg_fsm *fsm, enum
> > usb_otg_state old_state)
> > >  		fsm->a_wait_bcon_tmout = 0;
> > >  		break;
> > >  	case OTG_STATE_A_HOST:
> > > +		otg_stop_hnp_polling(fsm);
> > >  		otg_del_timer(fsm, A_WAIT_ENUM);
> > >  		break;
> > >  	case OTG_STATE_A_SUSPEND:
> > > --
> > 
> > It introduces circular locking after applying it, otg_statemachine calls
> > otg_leave_state, and otg_leave_state calls otg_statemachine again due to
> > flush work, see below dump:
> 
> How did you trigger this locking issue? I did some simple tests with
> this patch but no problems found.
>  

Just do srp repeat at b side.

counter=0
while [ 1 ] 
	do

	./srp.sh 0

	sleep 5

	./srp.sh 1

	sleep 5

	counter=$(( $counter + 1 ))
	echo "the counter is $counter"
done

root at imx6qdlsolo:~# cat srp.sh 
echo $1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req


> > 
> > I suggest moving initialization/flush hnp polling work to chipidea driver.
> > 
> 
> Since the HNP polling is done in common driver completely, so I think
> it's not proper to move some of it into controller driver.
> 

If we can keep one-shot operation well, like initialization and remove,
I have no idea to keep it like current way.

Peter
> 
> > [  183.086987] ======================================================
> > [  183.093183] [ INFO: possible circular locking dependency detected ]
> > [  183.099471] 4.7.0-rc4-00012-gf1f333f-dirty #856 Not tainted
> > [  183.105059] -------------------------------------------------------
> > [  183.111341] kworker/0:2/114 is trying to acquire lock:
> > [  183.116492]  (&ci->fsm.lock){+.+.+.}, at: [<806118dc>]
> > otg_statemachine+0x20/0x470
> > [  183.124199]
> > [  183.124199] but task is already holding lock:
> > [  183.130052]  ((&(&fsm->hnp_polling_work)->work)){+.+...}, at:
> > [<80140368>] process_one_work+0x128/0x418 [  183.139568] [  183.139568]
> > which lock already depends on the new lock.
> > [  183.139568]
> > [  183.147765]
> > [  183.147765] the existing dependency chain (in reverse order) is:
> > [  183.155265]
> > -> #1 ((&(&fsm->hnp_polling_work)->work)){+.+...}:
> > [  183.161371]        [<8013e97c>] flush_work+0x44/0x234
> > [  183.166469]        [<801411a8>] __cancel_work_timer+0x98/0x1c8
> > [  183.172347]        [<80141304>] cancel_delayed_work_sync+0x14/0x18
> > [  183.178570]        [<80610ef8>] otg_set_state+0x290/0xc54
> > [  183.184011]        [<806119d0>] otg_statemachine+0x114/0x470
> > [  183.189712]        [<8060a590>] ci_otg_fsm_work+0x40/0x190
> > [  183.195239]        [<806054d0>] ci_otg_work+0xcc/0x1e4
> > [  183.200430]        [<801403d4>] process_one_work+0x194/0x418
> > [  183.206136]        [<8014068c>] worker_thread+0x34/0x4fc
> > [  183.211489]        [<80146d08>] kthread+0xdc/0xf8
> > [  183.216238]        [<80108ab0>] ret_from_fork+0x14/0x24
> > [  183.221514]
> > -> #0 (&ci->fsm.lock){+.+.+.}:
> > [  183.225880]        [<8016ff94>] lock_acquire+0x78/0x98
> > [  183.231062]        [<80947c18>] mutex_lock_nested+0x54/0x3ec
> > [  183.236773]        [<806118dc>] otg_statemachine+0x20/0x470
> > [  183.242388]        [<80611df4>] otg_hnp_polling_work+0xc8/0x1a4
> > [  183.248352]        [<801403d4>] process_one_work+0x194/0x418
> > [  183.254055]        [<8014068c>] worker_thread+0x34/0x4fc
> > [  183.259409]        [<80146d08>] kthread+0xdc/0xf8
> > [  183.264154]        [<80108ab0>] ret_from_fork+0x14/0x24
> > [  183.269424]
> > [  183.269424] other info that might help us debug this:
> > [  183.269424]
> > [  183.277451]  Possible unsafe locking scenario:
> > [  183.277451]
> > [  183.283389]        CPU0                    CPU1
> > [  183.287931]        ----                    ----
> > [  183.292473]   lock((&(&fsm->hnp_polling_work)->work));
> > [  183.297665]                                lock(&ci->fsm.lock);
> > [  183.303639]
> > 	lock((&(&fsm->hnp_polling_work)->work));
> > [  183.311347]   lock(&ci->fsm.lock);
> > [  183.314801]
> > [  183.314801]  *** DEADLOCK ***
> > [  183.314801]
> > [  183.320745] 2 locks held by kworker/0:2/114:
> > [  183.325028]  #0:  ("events"){.+.+.+}, at: [<80140368>]
> > process_one_work+0x128/0x418
> > [  183.332817]  #1:
> > ((&(&fsm->hnp_polling_work)->work)){+.+...}, at: [<80140368>]
> > process_one_work+0x128/0x418
> > [  183.342772]
> > [  183.342772] stack backtrace:
> > [  183.347160] CPU: 0 PID: 114 Comm: kworker/0:2 Not tainted 4.7.0-rc4-
> > 00012-gf1f333f-dirty #856 [  183.355699] Hardware name: Freescale i.MX6
> > SoloX (Device
> > 		Tree)
> > [  183.361561] Workqueue: events otg_hnp_polling_work [  183.366388]
> > Backtrace:
> > [  183.368891] [<8010d014>] (dump_backtrace) from [<8010d208>]
> > (show_stack+0x18/0x1c)
> > [  183.376479]  r6:600001d3 r5:00000000 r4:80f21d3c r3:00000002
> > [  183.382265] [<8010d1f0>] (show_stack) from [<803f158c>]
> > (dump_stack+0xb4/0xe8)
> > [  183.389521] [<803f14d8>] (dump_stack) from [<8016c2b4>]
> > (print_circular_bug+0x1d0/0x314)
> > [  183.397625]  r10:81760be8 r9:00000000 r8:bdb7bc00 r7:bdb7c0e0
> > r6:810c7074 r5:810ea174
> > [  183.405585]  r4:810c7074 r3:00000002
> > [  183.409231] [<8016c0e4>] (print_circular_bug) from [<8016fa8c>]
> > (__lock_acquire+0x196c/0x1ab4) [  183.417857]  r10:80f21e1c r9:00000002
> > r8:00000001 r7:8174e47c
> > r6:00000002 r5:bdb7bc00
> > [  183.425814]  r4:00000026 r3:bdb7c0c0
> > [  183.429459] [<8016e120>] (__lock_acquire) from [<8016ff94>]
> > (lock_acquire+0x78/0x98)
> > [  183.437218]  r10:bdb701cc r9:bdbafeb0 r8:00001388 r7:00000001
> > r6:806118dc r5:60000153 [  183.445175]  r4:00000000 [  183.447758]
> > [<8016ff1c>] (lock_acquire) from [<80947c18>]
> > (mutex_lock_nested+0x54/0x3ec)
> > [  183.455864]  r7:bdb7bc00 r6:8174e47c r5:806118dc r4:00000000
> > [  183.461645] [<80947bc4>] (mutex_lock_nested) from [<806118dc>]
> > (otg_statemachine+0x20/0x470) [  183.470097]  r10:00000001 r9:bdbafeb0
> > r8:00001388 r7:bd3ef000
> > r6:00000009 r5:bdb701cc
> > [  183.478057]  r4:bdb70120
> > [  183.480641] [<806118bc>] (otg_statemachine) from [<80611df4>]
> > (otg_hnp_polling_work+0xc8/0x1a4)
> > [  183.489354]  r5:bdb70214 r4:00000000
> > [  183.493006] [<80611d2c>] (otg_hnp_polling_work) from [<801403d4>]
> > (process_one_work+0x194/0x418) [  183.501805]  r8:00000000 r7:be7c4400
> > r6:be7c0ec0 r5:bdb70214
> > r4:bdb2d600
> > [  183.508650] [<80140240>] (process_one_work) from [<8014068c>]
> > (worker_thread+0x34/0x4fc)
> > [  183.516754]  r10:bdb2d600 r9:be7c0ec0 r8:80f02100 r7:be7c0ef4
> > r6:00000008 r5:bdb2d618
> > [  183.524712]  r4:be7c0ec0
> > [  183.527297] [<80140658>] (worker_thread) from [<80146d08>]
> > (kthread+0xdc/0xf8)
> > [  183.534534]  r10:00000000 r9:00000000 r8:00000000 r7:80140658
> > r6:bdb2d600 r5:bdb51000
> > [  183.542492]  r4:00000000
> > [  183.545081] [<80146c2c>] (kthread) from [<80108ab0>]
> > (ret_from_fork+0x14/0x24)
> > [  183.552317]  r7:00000000 r6:00000000 r5:80146c2c r4:bdb51000
> > 
> > 
> > --
> > 
> > Best Regards,
> > Peter Chen

-- 

Best Regards,
Peter Chen

From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Mon, 18 Dec 2017 11:59:30 +0100
Subject: [PATCH] phy: rockchip-typec: Try to turn the PHY on several times
In-Reply-To: <CAD=FV=Vw3_foX0_VfFG8h0xVrEEfOCWmVfF6xDVg++AqBbDRCA@mail.gmail.com>
References: <20171211214553.118337-1-dianders@chromium.org>
 <CAFqH_52coxz73waki18JicDsndG9bzEw6Zbq6TCOST0J3N+NXQ@mail.gmail.com>
 <CAD=FV=Vw3_foX0_VfFG8h0xVrEEfOCWmVfF6xDVg++AqBbDRCA@mail.gmail.com>
Message-ID: <CAFqH_52wzLLm+5EfK_WcX9kKO7g5JOe=Thsd3PkaDiiApS2aZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2017-12-13 20:14 GMT+01:00 Doug Anderson <dianders@chromium.org>:
> Hi,
>
> On Wed, Dec 13, 2017 at 4:41 AM, Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>> Hi Doug,
>>
>> 2017-12-11 22:45 GMT+01:00 Douglas Anderson <dianders@chromium.org>:
>>> Bind / unbind stress testing of the USB controller on rk3399 found
>>> that we'd often end up with lots of failures that looked like this:
>>>
>>>   phy phy-ff800000.phy.9: phy poweron failed --> -110
>>>   dwc3 fe900000.dwc3: failed to initialize core
>>>   dwc3: probe of fe900000.dwc3 failed with error -110
>>>
>>> Those errors were sometimes seen at bootup too, in which case USB
>>> peripherals wouldn't work until unplugged and re-plugged in.
>>>
>>> I spent some time trying to figure out why the PHY was failing to
>>> power on but I wasn't able to.  Possibly this has to do with the fact
>>> that the PHY docs say that the USB controller "needs to be held in
>>> reset to hold pipe power state in P2 before initializing the Type C
>>> PHY" but that doesn't appear to be easy to do with the dwc3 driver
>>> today.  Messing around with the ordering of the reset vs. the PHY
>>> initialization in the dwc3 driver didn't seem to fix things.
>>>
>>> I did, however, find that if I simply retry the power on it seems to
>>> have a good chance of working.  So let's add some retries.  I ran a
>>> pretty tight bind/unbind loop overnight.  When I did so, I found that
>>> I need to retry between 1% and 2% of the time.  Overnight I found only
>>> a small handful of times where I needed 2 retries.  I never found a
>>> case where I needed 3 retries.
>>>
>>> I'm completely aware of the fact that this is quite an ugly hack and I
>>> wish I didn't have to resort to it, but I have no other real idea how
>>> to make this hardware reliable.  If Rockchip in the future can come up
>>> with a solution we can always revert this hack.  Until then, let's at
>>> least have something that works.
>>>
>>> This patch is tested atop Enric's latest dwc3 patch series ending at:
>>>   https://patchwork.kernel.org/patch/10095527/
>>> ...but it could be applied independently of that series without any
>>> bad effects.
>>>
>>> For some more details on this bug, you can refer to:
>>>   https://bugs.chromium.org/p/chromium/issues/detail?id=783464
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>>  drivers/phy/rockchip/phy-rockchip-typec.c | 24 ++++++++++++++++++++++--
>>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
>>> index ee85fa0ca4b0..5c2157156ce1 100644
>>> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
>>> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
>>> @@ -349,6 +349,8 @@
>>>  #define MODE_DFP_USB                   BIT(1)
>>>  #define MODE_DFP_DP                    BIT(2)
>>>
>>> +#define POWER_ON_TRIES                 5
>>> +
>>
>> I did the test of increase the number of tries to 100 because
>> unfortunately, even with this patch applied, I can see the problem on
>> my kevin with current mainline.
>>
>> [  244.309094] rockchip-typec-phy ff800000.phy: Turn on failed after 100 loops
>>
>> That's an extra debug print ^
>>
>> [  244.317019] phy phy-ff800000.phy.8: phy poweron failed --> -110
>> [  244.323824] dwc3 fe900000.dwc3: failed to initialize core
>> [  244.330057] dwc3: probe of fe900000.dwc3 failed with error -110
>>
>> So I'm wondering if there is something else that I need to apply to
>> really fix this as you didn't reproduce the issue doing lots of tests
>> and I can reproduce the issue very easily.
>
> Ah!  I added that message to the top of my upstream series and,
> indeed, I sometimes see the PHY fail to turn on.  Doh.
>
> OK, so here's what I've done:
>
> * The place where I ran the overnight loops was actually the Chrome OS
> 4.4 kernel.  In that kernel I had a message very similar to yours and
> I didn't hit it.  I just re-ran this for 20 minutes now and I can
> re-confirm.  In the Chrome OS kernel I never see it needing more than
> a 1 (or 2) loops and it doesn't ever get into the "totally failed"
> case.
>

Ok, blame me, so the reason I saw that message often is because my DT
missed the entries to define the reset (fixed in the latest series I
sent) So completely my fault.

> * Previously I ran ~10 minutes with the upstream kernel, but at the
> time I didn't have your printout.  After 10 minutes I checked my logs
> and I definitely saw the "Needed 1 loops to turn on", so I knew my
> patch was doing something useful.  It didn't occur to me to re-confirm
> that I didn't get the "totally failed" upstream, though now that I say
> it out loud it's stupid that I didn't think to do this.
>

Doing your bind/unbind stress test with mainline I'm getting some
errors though, the 'phy poweron failed --> -110' disapeared and your
patch helps.

But sometimes I get :

[ 6451.626640] usb 5-1: new high-speed USB device number 2 using xhci-hcd
[ 6451.814221] hub 5-1:1.0: USB hub found
[ 6451.819897] hub 5-1:1.0: 4 ports detected
[ 6451.914772] usb 6-1: new SuperSpeed USB device number 2 using xhci-hcd
[ 6451.958372] hub 6-1:1.0: USB hub found
[ 6451.962867] hub 6-1:1.0: 4 ports detected
[ 6452.152438] xhci-hcd xhci-hcd.1.auto: remove, state 1
[ 6452.158121] usb 5-1.2: new full-speed USB device number 3 using xhci-hcd
[ 6452.158126] usb 5-1.2: hub failed to enable device, error -108
[ 6452.172323] usb usb6: USB disconnect, device number 1
[ 6452.174638] hub 6-1:1.0: activate --> -19
[ 6452.182507] usb 6-1: USB disconnect, device number 2

And after some minutes of test I get a:

[ 9182.623783] Unable to handle kernel NULL pointer dereference at
virtual address 00000090
[ 9182.632831] Mem abort info:
[ 9182.635945]   ESR = 0x96000004
[ 9182.639350]   Exception class = DABT (current EL), IL = 32 bits
[ 9182.645959]   SET = 0, FnV = 0
[ 9182.649365]   EA = 0, S1PTW = 0
[ 9182.652866] Data abort info:
[ 9182.656076]   ISV = 0, ISS = 0x00000004
[ 9182.660355]   CM = 0, WnR = 0
[ 9182.663665] user pgtable: 4k pages, 48-bit VAs, pgd = 0000000087ab6ba9
[ 9182.670957] [0000000000000090] *pgd=0000000000000000
[ 9182.676504] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 9182.682727] Modules linked in: fuse mwifiex_pcie mwifiex cdc_ether
usbnet r8152 cfg80211 rfkill cros_ec_sensors cros_ec_sensors_core
indust
rialio_triggered_buffer kfifo_buf phy_rockchip_pcie snd_soc_max98357a
snd_soc_rk3399_gru_sound atmel_mxt_ts videobuf2_vmalloc
videobuf2_memops
 videobuf2_v4l2 crc32_ce videobuf2_core videodev crct10dif_ce
snd_soc_rockchip_i2s snd_soc_da7219 snd_soc_rt5514 snd_soc_rt5514_spi
cros_ec_de
vs rockchip_saradc snd_soc_rl6231 rockchip_thermal media pcie_rockchip
ip_tables x_tables ipv6
[ 9182.733489] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc3+ #39
[ 9182.740681] Hardware name: Google Kevin (DT)
[ 9182.745448] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[ 9182.750803] pc : xhci_irq+0x30c/0x1360
[ 9182.754986] lr : xhci_irq+0x40/0x1360
[ 9182.759071] sp : ffff000008003d90
[ 9182.762768] x29: ffff000008003d90 x28: ffff8000b4948220
[ 9182.768701] x27: 0000000000000001 x26: ffff00000a51d640
[ 9182.774633] x25: ffff00000914eb6b x24: 0000000000000000
[ 9182.780566] x23: 0000000000000000 x22: 0000000000000080
[ 9182.786499] x21: ffff8000b4948000 x20: ffff8000b494826c
[ 9182.792431] x19: ffff8000b4948000 x18: 0000000000040f00
[ 9182.798363] x17: 0000ffffb54b1b90 x16: ffff000008222b68
[ 9182.804296] x15: 0000000000000000 x14: 00000000000023de
[ 9182.810229] x13: 7fffffffffffffff x12: 0000000000000040
[ 9182.816161] x11: ffff8000f24cc000 x10: 000000000000001e
[ 9182.822093] x9 : ffff8000f24cc118 x8 : 0000000000000000
[ 9182.828026] x7 : ffff8000f1735000 x6 : 0000000000000001
[ 9182.833959] x5 : 0000000000000000 x4 : ffff8000c186e100
[ 9182.839891] x3 : 0000000000000001 x2 : 0000000000000002
[ 9182.845823] x1 : ffff8000b4948000 x0 : 0000000000000003
[ 9182.851758] Process swapper/0 (pid: 0, stack limit = 0x0000000049fd774f)
[ 9182.859242] Call trace:
[ 9182.861972]  xhci_irq+0x30c/0x1360
[ 9182.865769]  usb_hcd_irq+0x2c/0x48
[ 9182.869566]  __handle_irq_event_percpu+0x9c/0x128
[ 9182.874818]  handle_irq_event_percpu+0x1c/0x58
[ 9182.879778]  handle_irq_event+0x48/0x78
[ 9182.874818]  handle_irq_event_percpu+0x1c/0x58
[ 9182.884061]  handle_fasteoi_irq+0xa0/0x180
[ 9182.888634]  generic_handle_irq+0x24/0x38
[ 9182.893108]  __handle_domain_irq+0x5c/0xb8
[ 9182.897682]  gic_handle_irq+0xc4/0x180
[ 9182.901865]  el1_irq+0xb0/0x128
[ 9182.905370]  arch_cpu_idle+0x10/0x18
[ 9182.909361]  do_idle+0x11c/0x1e0
[ 9182.912962]  cpu_startup_entry+0x24/0x28
[ 9182.917343]  rest_init+0xd0/0xe0
[ 9182.920946]  start_kernel+0x398/0x3ac
[ 9182.925035] Code: f9400798 340035c0 7103fc1f 54004ac0 (b9409305)
[ 9182.931848] ---[ end trace dc830bbccf53c326 ]---

So there is still something wrong with current mainline that seems
it's solved in chromeos. I'll try to investigate a bit.

> * Previously when playing with patches on the upstream kernel I saw
> lots of problems powering on the PHY and I thought my patch was
> helping, but that was all very non-scientific.
>
>
> So to say it shortly:
>
> * For me, my patch makes things a slightly better even on the upstream
> kernel (I do sometimes see the "turned on after 1 tries")
>
> * I can confirm that my patch doesn't fix everything upstream, so
> there's something different about the Chrome OS tree still.
>
> ---
>
> I also picked all the local patches from the Chrome OS kernel to the
> PHY driver and now my PHY driver in the upstream and downstream trees
> match.  I can still reproduce problems.  So the issue is somewhere at
> a higher level...
>
>
> So basically something outside the PHY driver is causing it to fail
> unexpectedly upstream.  I guess the hacky retry won't work well enough
> there after all.  :(
>
> One question: if you get the "failed after 100 loops" and then you do
> another unbind / bind, does it work after that?  The original reason I
> got the idea to retry was because if I simply tried an unbind / bind
> again then things worked OK...
>
>
> -Doug

Regards,
-Enric

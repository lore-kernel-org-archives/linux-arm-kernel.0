From: mugunthanvnm@ti.com (N, Mugunthan V)
Date: Tue, 16 Oct 2012 23:11:29 +0000
Subject: [PATCH V2 0/7] support the cpts found on am335x devices
In-Reply-To: <20121016171407.GA2176@netboy.at.omicron.at>
References: <cover.1350329726.git.richardcochran@gmail.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9F82F0@DBDE01.ent.ti.com>
 <20121016171407.GA2176@netboy.at.omicron.at>
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293E9F86E9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Tuesday, October 16, 2012 10:44 PM
> To: N, Mugunthan V
> Cc: netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; David
> Miller; Chemparathy, Cyril; Govindarajan, Sriramakrishnan
> Subject: Re: [PATCH V2 0/7] support the cpts found on am335x devices
> 
> On Tue, Oct 16, 2012 at 04:33:55PM +0000, N, Mugunthan V wrote:
> > I had seen some issues with the patch series.
> 
> Please take another look. Excepting the last, none of your points
> holds water.
> 
> > * CPTS will hold only LSB 32 bits of 64 bit Timer and the upper 32
> bit
> >   time value has to be taken care by the software, but the time stamp
> >   which is passed to skb or PTP clock consist of only 32 bit time
> value
> 
> The driver handles this already.

Yes, I do agree that driver handles it. As Half roll over and Full roll
over events are not handled in the driver, I am just curious how will
the misaligned TS would be handled and also in cpts set time, the Lower
32 bit time is written to CPTS counter

> 
> > * CPTS interrupts should be utilized to service Half and Full roll
> over
> >   events as it is non sync events with respect to get/set time and
> PTP
> >   pkt Tx/Rx
> 
> Nope, no need for interrupts, since we already have a better way to
> handle this.

Since we poll for the 32bit over flow for every HZ * 8 cycle, won't
there be a system overhead. If the CPTS ref clock is changed according
to the ptp freq adjust api, how will the timecounter take care of change
in frequency

> 
> > * CPTS Time which is obtained from hardware is not actually a nano
> >   seconds as the CPTS ref clock is tied to 250MHz for AM335x.
> 
> Did you even look at the code in my patch?

I had gone through the patch, but the same driver can be used in TI814x
where the user has the option to change the frequency from 250MHz may to
1GHz also, I thought of how it will be handled if we fix the multiplication
factor

> 
> > * CPSW register mapping done in this patch series removes the CPSW
> >   driver support for previous version found in TI814x
> 
> In which Linux version (or commit) did this driver appear?
> I never saw it.

The current driver which is in vanilla kernel doesn't use extended slave
address which are conflict between TI814x CPSW IP version and AM335x CPSW
IP version. I have just posted my version of CPTS implementation. May be
we can work together make the driver compatible with both CPSW versions

> 
> > * CPSW Time stamping is done only for port 0 and port 1 is not done
> 
> Yes, you are right, and it is strange that the hardware time stamps on
> the external ports of the switch, and not at the host port as it
> should. Of course it does present us with a problem, since we cannot
> reasonably have both ports time stamping at the same time. I propose
> simply using a device tree attribute to tell which port to activate.

Since CPSW is a 3port Switch we should not fix time stamping will be enabled
only for slave 0 or passing slave number through DT. Its better if we
can configure both the slaves. This can be tested with EVM-sk which has
both the slave ports pinned out.

> 
> Thanks,
> Richard

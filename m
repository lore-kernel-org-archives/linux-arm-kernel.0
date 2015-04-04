From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 4 Apr 2015 13:14:31 +0000
Subject: [PATCH] i2c: cadence: Handling Slave monitor mode
In-Reply-To: <20150402202909.GA3501@katana>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
 <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
 <20150402202909.GA3501@katana>
Message-ID: <9ef3c612-b803-4937-bb21-0fac03969f39@BN1AFFO11FD037.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,


> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: Friday, April 03, 2015 1:59 AM
> To: Harini Katakam
> Cc: Nava kishore Manne; Michal Simek; Soren Brinkmann; linux-arm-
> kernel at lists.infradead.org; linux-i2c at vger.kernel.org; linux-
> kernel at vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Nava kishore
> Manne
> Subject: Re: [PATCH] i2c: cadence: Handling Slave monitor mode
>
>
> > >> In slave monitor mode, the I2C interface is set up as a master and
> > >> continues to attempt a transfer to a particular slave until the
> > >> slave device responds with an ACK.
> > >>
> > >> Added this feature for zero length transfers enable the controller
> > >> for slave monitor interrupt and get the status. Disable the slave
> > >> monitor mode feature upon successful handling.
> > >>
> > >> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > >> Acked-by: Harini Katakam <harinik@xilinx.com>
> > >
> > > I am not sure this is going to work.
> > >
> > > How often is this access tried when there is no device? It should be
> > > tried only once.
> >
> > Once slave monitor is enabled in the host controller, it retries till
> > there's an ACK or slave monitor is disabled. The SW wont be involved
> > and need not
>
> So, it is kind of flooding the bus until the timeout? That is not a single zero
> byte message.
>
It will not flooding the bus until the timeout. Once it fails to access the bus it will be ideal for 15 clock cycles. Master again retrying to access the
Slave immediately after the 15 clock cycles (There is a register in the controller to set the retry value min: 0 cycles, max: 16 cycles).This process will repeat until
The software timeout will happen (1000msec).

Regards,
Navakishore.
> > be interrupted in this gap. The way this feature works in the
> > controller though, I'm afraid there's no way to distinguish between no
> slave/ busy slave.
> > The out is the software timeout in that case.
> > Please suggest how to use this feature better.
>
> I suggest to not use the feature and accept that this device cannot do zero
> byte length messages.
>
> Thanks,
>
>    Wolfram



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

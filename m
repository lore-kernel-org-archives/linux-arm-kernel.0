From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Wed, 2 Apr 2014 09:40:53 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140402085914.GG7528@n2100.arm.linux.org.uk>
References: <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <b974be3a995f41029b54cfcc10c732ef@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402085914.GG7528@n2100.arm.linux.org.uk>
Message-ID: <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Data: Wednesday, April 02, 2014 4:59 PM

>To: Duan Fugang-B38611
>Cc: robert.daniels at vantagecontrols.com; Marek Vasut; Detlev Zundel; Troy Kisky;
>Grant Likely; Bernd Faust; Fabio Estevam; linux-arm-kernel at lists.infradead.org
>Subject: Re: FEC ethernet issues [Was: PL310 errata workarounds]
>
>On Wed, Apr 02, 2014 at 03:19:58AM +0000, fugang.duan at freescale.com wrote:
>> >	wmb();
>> >
>> >        /* Trigger transmission start */
>> >        if (readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
>> >                writel(0, fep->hwp + FEC_X_DES_ACTIVE);
>> >
>> >and see whether that helps your problem(s).
>> >
>> So far, I don't see wmb() bring any effort on FEC.  Some years ago, we
>> want to add wmb() before set BD "Ready" bit, but we don't find any
>> issue without wmb(), on the contrary, it introduce more System
>> overhead special for Gbps networking.
>
>I wonder whether you understand what is going on here, and why it is required.
>I doubt it somehow from your comments.  Maybe if you were to read about the
>operation of the store buffer in the PL310, it may open your eyes to why it
>would be necessary for reliable operation.
>
In kernel 3.0.35 internal BSP,  BD memory is non-cacheable, non-bufferable (we add new api to support it: dma_alloc_noncacheable()),
So wmb() is not necessary. We don't find net watchdog timeout/ ping order issue.

>> And now, imx6sx sillicon (sigle core), add wmb() cause tx performance
>> drop much since cpu loading is the bottleneck.
>
>I don't find any measurable performance drop from adding it on either iMX6Q or
>iMX6S with the L2 cache code fixed up.
>
Yes, it don't impact imx6q since cpu loading is not bottleneck due rx/tx bandwidth is slow and multi-cores.
But for imx6sx, enet rx can reach at 940Mbps, tx can reach at 900Mbps, imx6sx is sigle core. Enet IP don't support
TSO feaure, cpu loading is the bottleneck. Wmb() is very expensive which cause tx performance drop much.

>The reality is, with the mainline ethernet driver with no changes, the best it
>can do is around 300Mbps transmit and 400Mbps receive.  With both my L2 and FEC
>changes, this has increased to 500Mbps transmit and 570Mbps receive.  Plus it
>now works reasonably (though with lots of
>collisions) on half-duplex giving a 4 to 8 fold increase in speed there.
>
>I really don't care how your private BSP kernels perform.  It's not mainline,
>so it's not of any interest.
>
Yes, I agree. There have some arch/driver patches need to upstream to align the performance with internal bsp.

>--
>FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
>improving, and getting towards what was expected from it.
>

Thanks,
Andy

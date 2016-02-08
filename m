From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2016 17:23:02 +0000
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <CAKzmTe24iz1Ka7Kkke=ZTVbDGZxxDjBH0m2iEVCQOGuuEpi4Gg@mail.gmail.com>
References: <20160205090246.GE32272@lunn.ch>
 <20160205112907.796afb05@bbrezillon>
 <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
 <87vb632maf.fsf@free-electrons.com>
 <CAKzmTe1AqNQwjcsAULotd010NXuk1AYjj5p6UoqT_Zu=BCHdcw@mail.gmail.com>
 <87mvrf2l6p.fsf@free-electrons.com>
 <87io232kat.fsf@free-electrons.com> <8760y2vqje.fsf@natisbad.org>
 <87twlmdg2b.fsf@natisbad.org>
 <CAKzmTe24iz1Ka7Kkke=ZTVbDGZxxDjBH0m2iEVCQOGuuEpi4Gg@mail.gmail.com>
Message-ID: <20160208172302.GQ10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 04:14:49PM +0100, JM wrote:
> On Fri, Feb 5, 2016 at 10:04 PM, Arnaud Ebalard <arno@natisbad.org> wrote:
> > Hi,
> >
> >> I'll try and do the same now w/ CESA support compiled as module to see
> >> what I get. I'll keep you posted.
> >
> > root at mood:~# insmod /tmp/marvell-cesa.ko
> > [  573.897977] marvell-cesa f1030000.crypto: CESA device successfully registered
> >
> > root at mood:~# uname -a
> > Linux mood 4.4.0.duov2 #2 Fri Feb 5 21:42:49 CET 2016 armv5tel GNU/Linux
> >
> > root at mood:~# zcat /proc/config.gz | grep -i CESA
> > # CONFIG_CRYPTO_DEV_MV_CESA is not set
> > CONFIG_CRYPTO_DEV_MARVELL_CESA=m
> >
> > Cheers,
> >
> > a+
> >
> > ps: my config is temporarily at http://natisbad.org/config-duov2-cesa
> 
> I've built a vanilla 4.4.1 kernel image without any debian-specific
> patches but using the same oldconfig
> (http://heap.ovh/files/config-4.4.1.vanilla).
> 
> # uname -a
> Linux yukikaze 4.4.1.vanilla #1 Sat Feb 6 14:18:19 CET 2016 armv5tel GNU/Linux
> 
> # modprobe marvell_cesa allhwsupport=1
> 
> # dmesg | tail -n1
> [  116.972828] marvell-cesa: probe of f1030000.crypto failed with error -12
> 
> The dtb hasn't changed:
> # diff -s kirkwood-ts219-6282.dtb dtb-4.4.1.vanilla
> Files kirkwood-ts219-6282.dtb and dtb-4.4.1.vanilla are identical
> 
> I am also attaching lsmod: http://heap.ovh/files/lsmod-vanilla-4.4.1
> and full dmesg: http://heap.ovh/files/dmesg-vanilla-4.4.1
> 
> Perhaps I am missing something obvious? I suppose the next step would
> be to build a minimal kernel based on the config for the duov2?

As you have built your own kernel, may I suggest that you add some
debug code into mv_cesa_dev_dma_init(), mv_cesa_get_sram(), and
mv_cesa_probe() to print which of the many locations that returns
-ENOMEM is triggering the above error.

In passing, I notice that:

        cesa->regs = devm_ioremap_resource(dev, res);
        if (IS_ERR(cesa->regs))
                return -ENOMEM;

is wrong.  devm_ioremap_resource() returns an errno-encoded pointer
which should be used to report the error number.  This should be:

        cesa->regs = devm_ioremap_resource(dev, res);
        if (IS_ERR(cesa->regs))
                return PTR_ERR(cesa->regs);

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

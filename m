From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 29 Oct 2009 09:59:31 +0100
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with
	PICe->PCI bridge
In-Reply-To: <20091029085236.GN14091@buzzloop.caiaq.de>
References: <200910290936.40397.dk-arm-linux@gmx.de>
	<20091029085236.GN14091@buzzloop.caiaq.de>
Message-ID: <20091029095931.7a4c200d@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Oct 2009 09:52:36 +0100
Daniel Mack <daniel@caiaq.de> wrote:

> On Thu, Oct 29, 2009 at 10:36:40AM +0200, Dieter Kiermaier wrote:
> > ## Booting kernel from Legacy Image at 00800000 ...
> >    Image Name:   Linux-2.6.32-rc5-00081-g964fe08-
> >    Image Type:   ARM Linux Kernel Image (uncompressed)
> >    Data Size:    2390056 Bytes =  2.3 MB
> >    Load Address: 00008000
> >    Entry Point:  00008000
> >    Verifying Checksum ... OK
> >    Loading Kernel Image ... OK
> > OK
> > 
> > Starting kernel ...
> > 
> > Uncompressing Linux............................................................................................................................................................ done.
> 
> The problem most probably is that your kernel dies before the console is
> enabled, and hence you're not pointed to the actual problem.

And another thing: you can printout the buffer from U-boot by looking
at __log_buf, i.e.,

  [simkag at marrow kernel]$ nm vmlinux| grep __log_buf
  c03bde48 b __log_buf

Just subtract 0xc0000000 from the address to get the physical address.
So from U-boot:

  OpenRD>> md 0x3bde48
  003bde48: 5b3e353c 20202020 30302e30 30303030    <5>[    0.000000
  003bde58: 694c205d 2078756e 73726576 206e6f69    ] Linux version 
  003bde68: 2e362e32 342e3133 69732820 67616b6d    2.6.31.4 (simkag
  003bde78: 72616d40 29776f72 63672820 65762063    @marrow) (gcc ve
  003bde88: 6f697372 2e34206e 20342e33 43434728    rsion 4.3.4 (GCC
  [...]

// Simon

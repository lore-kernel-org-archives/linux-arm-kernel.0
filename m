From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 10:35:37 +0100
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <CAMbhsRQiU-UyiCWqjaWNXbhDd0+=Tv_pWoeQkJKJaHC6y4=HwQ@mail.gmail.com>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
 <8f0c9ced-cdc3-ab9b-caee-06fe85e6c1e7@arm.com>
 <CABXOdTfg2T2tZrQOd2S5SjeySAMbfQX0weFuvRXBr2o8Of9nVQ@mail.gmail.com>
 <20160816132103.GD27088@arm.com>
 <CABXOdTfHX_ZB1CuM7hzU5LCZPYdHvBSatN9Nen=rb8r1rXhz-g@mail.gmail.com>
 <20160815221518.GD1120@svinekod>
 <CAMbhsRQiU-UyiCWqjaWNXbhDd0+=Tv_pWoeQkJKJaHC6y4=HwQ@mail.gmail.com>
Message-ID: <20160819093537.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:52AM -0700, Colin Cross wrote:
> persistent_ram uses atomic ops in uncached memory to store the start
> and end positions in the ringbuffer so that the state of the
> ringbuffer will be valid if the kernel crashes at any time.  This was
> inherited from Android's ram_console implementation, and worked
> through armv7.

That statement is actually inaccurate.  It may have worked on _some_
ARMv7 implementations, but it's not architecturally compliant.

The exclusive access instructions are not portable to anything but
"normal memory":

   It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can
   be performed to a memory region with the Device or Strongly-ordered
   memory attribute. Unless the implementation documentation explicitly
   states that LDREX and STREX operations to a memory region with the
   Device or Strongly-ordered attribute are permitted, the effect of
   such operations is UNPREDICTABLE.

pgprot_noncached() gives strongly-ordered memory, and so is unsuitable
to place semaphores in for all ARMv7 implementations.

Also:

+       if (memtype)
+               va = ioremap(start, size);

this returns *device* memory, which is also unsuitable for all ARMv7
implementations.

It seems that pstore is playing in areas of the architecture which are
implementation defined, so it's no surprise that folk are seeing
different behaviours with different implementations.

The code isn't architecturally wrong, it just isn't portable to all ARMv7
implementations.

So, saying that it works on some ARMv7 implementations is irrelevent.

Note that LDREX and STREX are used for all operations that require
atomicity - iow, atomics and locks.

pgprot_writecombine() and ioremap_wc() will return memory which is
suitable for these exclusive accesses - it maps to the architectures'
"normal memory, uncacheable".

So, I suspect the OP should not be using mem_type=1 or using the
"unbuffered" DT attribute, but should leave it was the default
(mem_type=0).


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 17 Oct 2017 23:33:11 +0300
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
 <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
Message-ID: <20171017203311.obi4nqtdvlrxwarm@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 16, 2017 at 01:55:18PM +0200, Petr Cvek wrote:
> Dne 15.10.2017 v 12:46 Aaro Koskinen napsal(a):
> > This seems to be simpler to debug/reproduce using busybox. Compiling
> > just busybox with GCC 7.2 and march=armv5te/mtune=xscale already
> > produces failing xz decompression:
> 
> Does it fail too when compiled with gcc 7.2 and with march=armv5t and/or
> march=armv4t ?

At least armv4t seems to work.

> > root at thecus-n2100:~$ gzip foo.txt
> > root at thecus-n2100:~$ ./busybox.gcc-7.2 gzip -d foo.txt.gz
> > gzip: crc error
> > root at thecus-n2100:~$ ./busybox.gcc-6.4 gzip -d foo.txt.gz
> > root at thecus-n2100:~$ cat foo.txt
> > foo
> > 
> 
> Is it really compiled with armv5te ("readelf -n -A")?

Yes.

> I've just found my old gcc 6.3 compiled some code with a default armv4t.

You can set the default with compiling GCC using --with-arch=...

BTW, the failing instruction seems to be STRD and there seems to be
already a related bug report:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82445

A.

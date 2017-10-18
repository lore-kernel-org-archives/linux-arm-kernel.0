From: petrcvekcz@gmail.com (Petr Cvek)
Date: Wed, 18 Oct 2017 11:57:13 +0200
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <20171017203311.obi4nqtdvlrxwarm@darkstar.musicnaut.iki.fi>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
 <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
 <20171017203311.obi4nqtdvlrxwarm@darkstar.musicnaut.iki.fi>
Message-ID: <8d660a74-afd5-a757-8a59-39283404c2f9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 17.10.2017 v 22:33 Aaro Koskinen napsal(a):
> Hi,
> 
Hi,

> On Mon, Oct 16, 2017 at 01:55:18PM +0200, Petr Cvek wrote:
>> Dne 15.10.2017 v 12:46 Aaro Koskinen napsal(a):
>>> This seems to be simpler to debug/reproduce using busybox. Compiling
>>> just busybox with GCC 7.2 and march=armv5te/mtune=xscale already
>>> produces failing xz decompression:
>>
>> Does it fail too when compiled with gcc 7.2 and with march=armv5t and/or
>> march=armv4t ?
> 
> At least armv4t seems to work.
> 

Are you sure you used gcc 7.2 and parameters march=armv5te + 
mtune=xscale? I've compiled the bugzilla code with these same parameters:

	-march=armv5te -mtune=xscale -marm -O2  -c strd.c

For me (on gcc 7.1.0) only mtune=xscale/iwmmxt doesn't generate STRD. 
Other mtune variants (arm1020e, arm926ej-s generate it). Here is a 
table, which was tested on a real hardware.

-march=armv5te -mtune=xscale	OK, code very long
-march=armv5te -mtune=iwmmxt	OK, same code as v5te/xscale
-march=iwmmxt			OK, same code as v5te/xscale
-march=armv5t			OK, less opcodes than v5te/xscale
-march=armv5			OK, same as armv5t
-march=armv5te			KO, unaligned STRD, alignment exception
-march=armv5tej			KO, unaligned STRD (PXA27x is only v5te)

BTW gcc 6.3.0 generates even longer code and it doesn't support armvtej. 
Perhaps your 7.2 has even more optimalizations even for mtune=xscale.

So I suppose compiling kernel and userspace with -match=armv5t or less 
should be fine for now (unless there is another similar problem due to 
7.x optimizations).

> 
>> I've just found my old gcc 6.3 compiled some code with a default armv4t.
> 
> You can set the default with compiling GCC using --with-arch=...

Yeah I know about that, it seems something probably override my settings 
(most likely my scripts for separate crosstool and buildroot).

> 
> BTW, the failing instruction seems to be STRD and there seems to be
> already a related bug report:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82445

Big thanks for info.

> 
> A.
> 

Petr

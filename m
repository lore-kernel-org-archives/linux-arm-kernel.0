From: petrcvekcz@gmail.com (Petr Cvek)
Date: Mon, 16 Oct 2017 13:55:18 +0200
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
Message-ID: <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne 15.10.2017 v 12:46 Aaro Koskinen napsal(a):
> Hi,
> 
> On Sat, Oct 14, 2017 at 11:57:30PM +0200, Robert Jarzmik wrote:
>> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
>>> On Sat, Sep 02, 2017 at 11:50:55PM +0200, Andrea Adami wrote:
>>>> On Thu, Jul 20, 2017 at 8:57 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>>>> Andrea Adami <andrea.adami@gmail.com> writes:
>>>>> I have the same report on userspace side on buildroot from Petr [1], which
>>>>> triggers endless segfaults in userspace (init) with gcc7 while everything is
>>>>> fine with gcc6. I have confirmation on my test farm the problem happens as well.
>>>>>
>>>>> Since debugging in userspace is far easier, I would suggest attacking the debug
>>>>> with Petr on userspace side, and once sorted out, come back to kernel side.
>>>>
>>>> sorry for the delay, I was awaiting to test gcc 7.2 and binutils 2.29.
>>>> Unfortunately, same issue: XZ-compressed data is corrupt - System Halted.
>>>
>>> Has anyone been able to debug this further? It seems there are also issues
>>> on iop32x/n2100 with GCC 7.2 and binutils 2.29.1 - early boot hangs silently
>>> and I cannot get earlyprintk to work. Compiling with GCC 6.4.0 it's OK.
>>
>> I didn't find the time for GCC 7.2 testing.
>> Yet I have earlyprintk working on my platforms, you need :
>>   - on kernel command line for ttyS0 in my case :
>>     earlycon=early_pxa,mmio,0x40100000
> 
> It dies already during decompression so earlycon does not help much.
> 
> This seems to be simpler to debug/reproduce using busybox. Compiling
> just busybox with GCC 7.2 and march=armv5te/mtune=xscale already
> produces failing xz decompression:
> 

Does it fail too when compiled with gcc 7.2 and with march=armv5t and/or 
march=armv4t ?

> root at thecus-n2100:~$ echo foo > foo.txt
> root at thecus-n2100:~$ xz foo.txt
> root at thecus-n2100:~$ ./busybox.gcc-7.2 xz -d foo.txt.xz
> xz: corrupted data
> root at thecus-n2100:~$ ./busybox.gcc-6.4 xz -d foo.txt.xz
> root at thecus-n2100:~$ cat foo.txt
> foo
> 
> gzip is no better:
> 
> root at thecus-n2100:~$ gzip foo.txt
> root at thecus-n2100:~$ ./busybox.gcc-7.2 gzip -d foo.txt.gz
> gzip: crc error
> root at thecus-n2100:~$ ./busybox.gcc-6.4 gzip -d foo.txt.gz
> root at thecus-n2100:~$ cat foo.txt
> foo
> 

Is it really compiled with armv5te ("readelf -n -A")? I've just found my 
old gcc 6.3 compiled some code with a default armv4t.

Petr

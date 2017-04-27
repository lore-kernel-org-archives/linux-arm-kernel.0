From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Apr 2017 10:20:56 +0100
Subject: Duplicate .plt sections warning with CONFIG_ARM_MODULE_PLTS
In-Reply-To: <6bd5005b-61d1-d2f9-fb0f-5ce200bfffd9@gmail.com>
References: <1fb01fb6-3306-1d96-1da0-5b732555dfaf@gmail.com>
 <CAKv+Gu8h9-MRKm6gxn79voW6sR0EQ5e2zNLRwh2vfew8Sfr42w@mail.gmail.com>
 <6bd5005b-61d1-d2f9-fb0f-5ce200bfffd9@gmail.com>
Message-ID: <CAKv+Gu983D46V7xf-SwZ2mxP+4SyEk9pO_SsY=2RmA+6fkA4-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2017 at 00:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 04/26/2017 12:33 AM, Ard Biesheuvel wrote:
>> On 26 April 2017 at 00:35, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> Hi Ard,
>>>
>>> While using CONFIG_ARM_MODULES_PLTS=y along with a large kernel module,
>>> I was able to have the kernel/module.c::add_sect_attrs() to complain
>>> about duplicate .plt sections found, each section gets its own sysfs
>>> attribute created under /sys/module/<modname>/sections/<sectname>
>>>
>>> And indeed the module has the following section headers and contents
>>> (see below). Is this something that looks legit or should we patch
>>> kernel/module.c to detect such duplicates and generate unique sysfs
>>> attribute section names instead? There does not appear to be any
>>> functional issue with that.
>>>
>>
>> Does it happen with a clean build?
>
> Yes it does, it was not quite the problem see below.
>
>> The .plt/.init.plt sections are
>> declared in the linker scripts, and so no module object should have
>> any such sections until the relocatable link occurs that combines them
>> all into a .ko, and it is at this point that these sections are
>> declared.
>
> It turned out that the module build I was debugging was built in a
> strange way with a first step producing foo.o_shipped, which (semi)
> manually pulling into the kernel's linker scripts, and then,
> foo.o_shipped was used to link foo.ko which then again got the linker
> scripts from the kernel. This is how we ended up with the two .plt and
> two .init.plt sections being present in foo.ko.
>

OK, so the fix is "don't do that" :-)

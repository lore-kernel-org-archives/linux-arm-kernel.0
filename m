From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Sep 2012 16:02:49 -0500
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5051816A.3050705@linutronix.de>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
 <5050CE33.9060909@ti.com> <5050E965.5080405@linutronix.de>
 <505107DF.5020105@gmail.com> <5051816A.3050705@linutronix.de>
Message-ID: <505249F9.7050201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 01:47 AM, Sebastian Andrzej Siewior wrote:
> On 09/13/2012 12:08 AM, Rob Herring wrote:
>>> Geert is right here. If it is a physical address, it should be
>>> phys_addr_t.
>>
>> While generally true, for the DT specific code I think it should be a
>> fixed u64. The size of the address is defined by the FDT, not the
>> kernel. It is very likely we could have a FDT that specifies addresses
>> in 64-bit values, but then we boot a kernel is compiled for !LPAE.
>> phys_addr_t is currently sized based on LPAE setting.
> 
> If your kernel is 32bit without PAE and your DTB address is >32ibt than
> you can't handle it. If you don't notice this in your dt code than you
> remap the wrong memory ioremap().

The size of the initrd fields are set by #address-cells properties and
determined when you create the dtb. The address to load the initrd is
decided by the bootloader/user and set at that point later in time. The
dtb should not be tied to the kernel you are booting. Obviously, if you
want to boot a non-PAE kernel, everything has to be placed at <4GB.

I can boot i386 and i386-pae kernels on an i386-pae machines. I expect
to generally be able to do that on ARM. Perhaps some SOCs like this one
will not allow that, it is not always true.

Rob

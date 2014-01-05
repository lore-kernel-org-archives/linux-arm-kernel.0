From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 05 Jan 2014 23:29:32 +0100
Subject: [PATCH v4 4/4] ARM: BCM5301X: workaround suppress fault
In-Reply-To: <201401052125.40130.arnd@arndb.de>
References: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
 <1388944697-19927-5-git-send-email-hauke@hauke-m.de>
 <201401052125.40130.arnd@arndb.de>
Message-ID: <52C9DCCC.9030801@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2014 09:25 PM, Arnd Bergmann wrote:
> On Sunday 05 January 2014, Hauke Mehrtens wrote:
>> Without this patch I am getting a unhandled fault exception like this
>> one after "Freeing unused kernel memory":
>>
>> Freeing unused kernel memory: 1260K (c02c1000 - c03fc000)
>> Unhandled fault: imprecise external abort (0x1c06) at 0xb6f89005
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
>>
>> The address which is here 0xb6f89005 changes from boot to boot, with a
>> new build the changes are bigger. With kernel 3.10 I have also seen
>> this fault at different places in the boot process, but starting with
>> 3.11 they are always occurring after the "Freeing unused kernel memory"
>> message. I never was able to completely boot to userspace without this
>> handler. The abort code is constant 0x1c06. This fault just happens
>> once in the boot process I have never seen it happing twice or more.
> 
> How about narrowing down the abort handler to only ignore a single
> fault after boot, and only with the abort code 0x1c06? That way you
> don't risk silent data corruption in case something else goes wrong
> after booting.

Ok I extended the bcm5301x_abort_handler() to only ignore the fault when
the code is 0x1c06 and it is the first fault.

>> This workaround was copied from the vendor code including most of the
>> comments. It says it they think this is caused by the CFE boot loader
>> used on this device. I do not have any access to any datasheet or
>> errata document to check this.
> 
> Does the SoC by chance have a PCI host controller? The only other
> platforms with this kind of handler have it to catch things going wrong
> with PCI. Maybe another thing to try is to turn off the PCI core
> at early boot.

Yes it has two PCIe host controller. I haven't tried to initialized the
PCIe core. It could be that the boot loader did something with the PCIe
controller, but I do not think so.

Hauke

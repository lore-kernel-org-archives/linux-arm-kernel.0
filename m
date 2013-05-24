From: itooo@itooo.com (Greg)
Date: Fri, 24 May 2013 12:25:48 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523234024.GU18614@n2100.arm.linux.org.uk>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523142301.10dbeff9@skate>
 <20130523202643.GQ18614@n2100.arm.linux.org.uk>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
 <20130524011724.515eac91@skate>
 <20130523234024.GU18614@n2100.arm.linux.org.uk>
Message-ID: <519F402C.9050801@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/05/2013 01:40, Russell King - ARM Linux a ?crit :
> On Fri, May 24, 2013 at 01:17:24AM +0200, Thomas Petazzoni wrote:
>> Russell,
>>
>> On Fri, 24 May 2013 00:09:11 +0100, Russell King - ARM Linux wrote:
>>
>>> No, I'm not asking about the principle.  I'm asking _in this particular
>>> problem case_ who provides the DT blob?
>>>
>>> So the person to answer that question is Thomas or someone who is using
>>> the boards concerned.
>> The DTB is built from arch/arm/boot/dts/, together with the kernel
>> image itself. As far as I'm aware of, there is for the moment no plan
>> to "burn" the DTB on the board and therefore make the Device Tree
>> really separated from the kernel.
> Right, so we're still in the position where we aren't dealing with
> vendor provided DT blobs... this also means of course that the DT blob
> isn't going to get updated by the boot loader depending on where it
> decides to set the registers.
>
> I suspect as far as the boot loaders on these boards go, the DT blob is
> "just another file" to be loaded into memory by the boot loader, and it
> is completely untouched by the boot loader.
>
Russell,

this is a little more complicated, the bootloader does touch the DT 
blob, for example it sets the MAC addresses of the network interfaces, I 
believe it also sets UART0 parameters. It does this silently if it 
founds entries it knows about in the DT blob.

I guess the good idea would have been to ask Marvell to also update an 
MBUS entry in the DT blob instead of doing the CP15 trick. This would 
not have solved the earlyprintk problem however.
I also guess this is not feasible anymore since it would imply to have 3 
different bootloader possibilities and 2 already is a pain to deal with.

Does this raise any new idea to someone ?

Cheers,

PS: I also got Marvell's confirmation, there is no way to avoid CPU hang 
when accessing an unmapped memory address, this triggers an external 
abort exception which is not recoverable in kernel mode.

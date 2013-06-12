From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 12:54:59 +0100
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <2456741.M6ZcdeZsEr@wuerfel>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20835253.Agl4DfuI3k@wuerfel> <20130612110746.5D6943E0A56@localhost>
 <2456741.M6ZcdeZsEr@wuerfel>
Message-ID: <CACxGe6v5wDK8nvuEZJ3o=pL7tvz-xdVwfnZFQjywL=JNZaHitQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 12:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 June 2013 12:07:46 Grant Likely wrote:
>>
>> It actually seems a bit silly to put the internal regs into the ranges
>> property at all. It's not like they need to be translated or provided to
>> any child nodes. Just give the root node a reg property with the correct
>> base for the internal regs.
>
> I think you are missing some background about the internal-regs:

True, I came into this conversation late.

> * These are SoC-wide registers including the UART and other things, not
>   just the mbus setup
> * There are at least two different values used for the internal-regs
>   mapping address depending on the SoC and boot loader version
> * We have to get the address from the DT since it is impossible to
>   probe or change without knowing the current setting: The internal-regs
>   also contains the registers in mbus used to relocate the internal-regs.

I wasn't actually suggesting to not get the address from DT, but your
point is taken; there is a lot more to internal regs than I had
assumed.

>
>> As for regenerating the ranges; I have no problem with the kernel
>> allocating ranges at runtime, but that code should not be creating a new
>> ranges property and adding it to the tree. The knowledge should be kept
>> internal to the driver and it should use an of_bus translator
>> (drivers/of/address.c) to tap into the ranges parsings code.
>
> Ok, makes sense. I didn't know about the of_bus code. Thanks for the
> pointer!
>
>         Arnd

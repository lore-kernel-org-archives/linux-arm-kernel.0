From: cedric@precidata.com (Cedric Berger)
Date: Tue, 23 Apr 2013 10:06:47 +0200
Subject: [PATCH 2/10] LPC32XX: 002-mmc.1: Workaround for MMC+DMA on LPC32xx
In-Reply-To: <20130418095650.GK14496@n2100.arm.linux.org.uk>
References: <E1USZDI-0006T8-MV@merlin.infradead.org>
 <20130418095650.GK14496@n2100.arm.linux.org.uk>
Message-ID: <51764117.20905@precidata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/18/13 11:56 AM, Russell King - ARM Linux wrote:
> On Wed, Apr 17, 2013 at 10:42:50PM +0200, Cedric Berger wrote:
>> Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
>> ---
>> the connection between the MMC controller and the DMA on NXP LPC32xx has
>> silicon bugs. NXP did a patch to workaround this, but it has not been commited
>> on the main branch. This is a rework of that patch for 3.9 kernel.
>
> Again, this should be in the commit description.
>
>> +#ifdef CONFIG_ARCH_LPC32XX
>> +	/*
>> +	 * The LPC32XX do not support sg on TX DMA. So
>> +	 * a temporary bounce buffer is used if more than 1 sg segment
>> +	 * is passed in the data request. The bounce buffer will get a
>> +	 * contiguous copy of the TX data and it will be used instead.
>> +	 */
>
> I don't think this is a silicon bug.  If you read the PL08x and PL18x
> manuals carefully, you will come to the realisation that the whole thing
> is a buggered up design - the PL08x will ignore the individual segment
> lengths when using flow control, and rely on the PL18x to tell it when
> to move to the next DMA segment, but the PL18x will only signal that at
> the end of the transfer.
>
> Someone in ARM Ltd did not have their head screwed on properly when they
> designed this.  I decided to totally scrap the idea of getting this crap
> working on ARMs evaluation boards because of this - but if we have real
> platforms with this problem, we shouldn't limit it to just those
> platforms.
>
> However, the problem affects both transmit and receive sides when flow
> control is used - I don't remember if FC is supposed to be used with
> receive with the PL18x though.

Hello,

I just sent a new set of patches (the first 4 mmc-related).
Is that something like that you wanted?

Thanks for looking into that.
Cedric

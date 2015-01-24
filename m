From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 Jan 2015 22:40:53 +0100
Subject: [PATCH 1/2] ARM: ux500: Move struct
In-Reply-To: <CAKXHbyOhD5_cHRp02AuhcYFR5m8nBvWzdsygUdw689LrS9R67g@mail.gmail.com>
References: <1421881782-23716-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20150122074458.GL22024@x1>
 <CAKXHbyOhD5_cHRp02AuhcYFR5m8nBvWzdsygUdw689LrS9R67g@mail.gmail.com>
Message-ID: <1749867.D7qte28FRP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 January 2015 18:33:00 Rickard Strandqvist wrote:
> 2015-01-22 8:44 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> >
> > Are you sure a struct is required at all now?  It only contains a
> > single bool after all.
> 
> 
> Hi Lee
> 
> Okay, I will gladly remove ab8500_ext_regulator_cfg completely.
> And I will try to update the comments, but since I'm not so familiar
> with what this code was meant to do it is a little more difficult.
> 

Try to take small steps then: See if there is something in this code
that is either never called, or data structures that are only
written but never read, or pointers that are verifiably always 
NULL, then eliminate one piece of the code at a time, with a patch
that explains what you found.

Try to make sure everything still builds after each patch, and note
that this was not the case with your first patch, though it would have
worked in the reverse order.

I suspect the best way forward is to actually move all of
ab8500_regulator_plat_data and whatever it references into
drivers/regulator/ab8500-ext.c because there now is only one
remaining instance of that. After this move, you can delete
a lot of code in arch/arm/mach-ux500 and possibly move all of
include/linux/regulator/ab8500.h into drivers/regulator/ab8500-ext.c
as well.

	Arnd

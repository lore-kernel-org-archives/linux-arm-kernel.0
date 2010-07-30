From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Jul 2010 17:26:02 +0200
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-Reply-To: <op.vgnwp8107p4s8u@pikus>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<op.vgnwp8107p4s8u@pikus>
Message-ID: <20100730152602.GA28042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Micha?,

On Fri, Jul 30, 2010 at 05:16:46PM +0200, Micha? Nazarewicz wrote:
> On Fri, 30 Jul 2010 16:49:14 +0200, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>
>> This is like usb_gadget_register_driver with the only difference that it
>> gets the bind function as parameter instead of using driver->bind.  This
>> allows fixing section mismatches like
>>
>> 	WARNING: drivers/usb/gadget/g_printer.o(.data+0xc): Section mismatch in
>> 	reference from the variable printer_driver to the function
>> 	.init.text:printer_bind()
>> 	The variable printer_driver references
>> 	the function __init printer_bind()
>>
>> by using usb_gadget_probe_driver with driver->bind = NULL.  When all
>> drivers are fixed to use the new function the bind member of struct
>> usb_gadget_driver can go away.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
>> Cc: Greg Kroah-Hartman <gregkh@suse.de>
>> ---
>> Hello,
>>
>> there is an alternative patch in Greg's tree [1], but IMHO mine is
>> better as it doesn't need __ref.
>>
>> Thoughts?
>
> Personally I don't see advantage of this over changing the __init to __ref.
> Or am I missing something?  I see your patch as an unnecessary API change.
> The way I understand it, __ref was introduced exactly for cases like this
> one where function is referenced from "normal" data but used only during
> init.  Could you try to clarify for me why you think your solution is
> better then mine?
- Using __ref instead of __init moves all bind functions from .init.text
  to .text and so the code isn't freed after booting or module loading.
  (OK, you could fix this by marking the driver structs as __ref and
  keep __init for the bind functions.)

- Using __ref might hide section mismatches.  (Your patch hasn't this
  problem as the bind functions used to live in .init.text, so any
  reference to .init should be OK assuming that it was OK to live in
  .init.text in the first place.  But when marking the driver structs
  this is an issue.)  That's why I don't like __ref and said my patch
  were better as it doesn't make use of it.

- The bind functions are only called at init time, so there is no need
  to save a pointer to it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

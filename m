From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 15:46:32 +0200
Subject: [PATCH RESEND 0/8] i2c: Relax mandatory I2C ID table passing
In-Reply-To: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140912134632.GE1930@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 03:35:30PM +0100, Lee Jones wrote:
> Hi Wolfram,
> 
> Placing this firmly back on your plate.  I truly hope we don't miss
> another merge-window.  This patch-set has the support of some pretty
> senior kernel maintainers, so I hope acceptance shouldn't be too
> difficult.
> 
> As previously discussed I believe it should be okay for an I2C device
> driver _not_ supply an I2C ID table to match to.  The I2C subsystem
> should be able to match via other means, such as via OF tables.  The
> blocking factor during our previous conversation was to keep
> registering via sysfs up and running.  This set does that.

As mentioned in another thread, modaliases are one other possible side
effect. As Javier correctly mentions, the beaviour does not really
change with your patchset. Yet, if we remove i2c_device_id from drivers
too carelessly, they might not be bound anymore.

> 
> After thinking more deeply about the problem, it occurred to me that
> any I2C device driver which uses the sysfs method and issues an
> of_match_device() would also fail their probe().  Bolted on to this
> set is a new, more generic way for these devices to match against
> either of the I2C/OF tables.
> 
> I hope this ticks all of your boxes.
> 
> v3:
>   - Insist on passing 'struct i2c_client' instead of 'struct device'
>   - Remove hook from of_match_device()
> 
> v2:
>   - Removal of ACPI support (this is really an OF issue).
>   - Add a new .probe2( with will seamlessly replace
>   - Supply a warning on devices matching via OF without a suitable compatible
>   - Remove unified match_device() - bad idea as it subverts type-safe behaviour
>   - Provide examples of the kind of clean-up possible after this set.
>     - I already have the full support from the maintainer of these drivers =;-)
> 
> Kind regards,
> Lee
> 
> Lee Jones (8):
>   i2c: Add pointer dereference protection to i2c_match_id()
>   i2c: Add the ability to match device to compatible string without an
>     of_node
>   i2c: Match using traditional OF methods, then by vendor-less
>     compatible strings
>   i2c: Make I2C ID tables non-mandatory for DT'ed devices
>   i2c: Export i2c_match_id() for direct use by device drivers
>   i2c: Provide a temporary .probe2() call-back type
>   mfd: 88pm860x: Move over to new I2C device .probe() call
>   mfd: as3722: Rid driver of superfluous I2C device ID structure
> 
>  drivers/i2c/i2c-core.c      | 72 +++++++++++++++++++++++++++++++++++++++------
>  drivers/mfd/88pm860x-core.c |  5 ++--
>  drivers/mfd/as3722.c        | 12 ++------
>  include/linux/i2c.h         | 22 +++++++++++++-
>  4 files changed, 88 insertions(+), 23 deletions(-)
> 
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/33a1ade2/attachment.sig>

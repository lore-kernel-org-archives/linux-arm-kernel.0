From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 07 Jun 2014 00:33:41 +0100
Subject: [PATCH 0/9] i2c: Relax mandatory I2C ID table passing (+ some
 creep)
In-Reply-To: <1402069952-28022-1-git-send-email-lee.jones@linaro.org>
References: <1402069952-28022-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140606233341.D7C75C42771@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  6 Jun 2014 16:52:23 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> Hi Wolfram,
>   
> As previously discussed I believe it should be okay for an I2C device
> driver _not_ supply an I2C ID table to match to.  The I2C subsystem
> should be able to match via other means, such as via OF tables.  The
> blocking factor during our previous conversation was to keep
> registering via sysfs up and running.  This set does that.
>   
> After thinking more deeply about the problem, it occurred to me that
> any I2C device driver which uses the sysfs method and issues an
> of_match_device() would also fail their probe().  Bolted on to this
> set is a new, more generic way for these devices to match against
> either of the I2C/OF tables.
> 
> I hope this ticks all of your boxes.
> 
> v2:
>   - Removal of ACPI support (this is really an OF issue).
>   - Add a new .probe2( with will seamlessly replace
>   - Supply a warning on devices matching via OF without a suitable compatible
>   - Remove unified match_device() - bad idea as it subverts type-safe behaviour
>   - Provide examples of the kind of clean-up possible after this set.
>     - I already have the full support from the maintainer of these drivers =;-) 

Aside from patch 7/9 and the comment I made about struct device vs.
struct i2c_client in the API, I think this series looks good. You can
add my acks to 1-6 and 8-9. Number 7 is nacked.

Acked-by: Grant Likely <grant.likely@linaro.org>

g.

> 
> Kind regards,
> Lee
> 
>  drivers/i2c/i2c-core.c      | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  drivers/mfd/88pm860x-core.c |  5 ++---
>  drivers/mfd/as3722.c        | 12 ++----------
>  drivers/of/device.c         | 19 ++++++++++++++++++-
>  include/linux/i2c.h         | 29 ++++++++++++++++++++++++++++-
>  5 files changed, 114 insertions(+), 24 deletions(-)
> 

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Dec 2015 10:36:07 +0100
Subject: [PATCH v2 1/3] reset: Add shared reset_control_[de]assert variants
In-Reply-To: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151214093607.GF19456@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 11, 2015 at 04:41:58PM +0100, Hans de Goede wrote:
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index c4c097d..1cca8ce 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -11,6 +11,8 @@ int reset_control_reset(struct reset_control *rstc);
>  int reset_control_assert(struct reset_control *rstc);
>  int reset_control_deassert(struct reset_control *rstc);
>  int reset_control_status(struct reset_control *rstc);
> +int reset_control_assert_shared(struct reset_control *rstc);
> +int reset_control_deassert_shared(struct reset_control *rstc);

Shouldn't that be handled in reset_control_get directly?

That would allow to share more code between the implementations, since
it would just be a flag to test in the get and not duplicate the
function definitions, and we could simply rely on the refcount to know
if we have to actually assert / deassert the device, in all the cases
(shared or not).

That would also allow us to catch easily if we're going to be able a
shared reset line or not, with the regular reset_control_get being
exclusive, and reset_control_get_shared or reset_control_get(..,
RESET_SHARED) being shared.

It would also avoid ending up with the shared variant used in every
generic driver eventually. We could just use the variant to see if we
have to use the shared get or not, and the rest of the driver is left
untouched, which is way less intrusive.

Moreover, it's also pretty much the pattern used everywhere else
(irqs, regulator, clocks, etc.), so it's going to be easier to review
as well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/28af2838/attachment.sig>

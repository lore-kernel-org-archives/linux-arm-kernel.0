From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 13 Jun 2016 18:53:36 -0700
Subject: [RESEND/PATCHv4 v4 2/3] firmware: Provide infrastructure to make
 fw caching optional
In-Reply-To: <20160607164741.31849-3-stephen.boyd@linaro.org>
References: <20160607164741.31849-1-stephen.boyd@linaro.org>
 <20160607164741.31849-3-stephen.boyd@linaro.org>
Message-ID: <CAB=NE6WQP9V_0W55pre4my=vHS1=eX8_BK2AVJGNpXViw0EVFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 9:47 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> From: Vikram Mulukutla <markivx@codeaurora.org>
>
> Some low memory systems with complex peripherals cannot afford to
> have the relatively large firmware images taking up valuable
> memory during suspend and resume. Change the internal
> implementation of firmware_class to disallow caching based on a
> configurable option. In the near future, variants of
> request_firmware will take advantage of this feature.
>
> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> [stephen.boyd at linaro.org: Drop firmware_desc design and use flags]
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/base/firmware_class.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index 01d55723d82c..45ed20cefa10 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -112,6 +112,7 @@ static inline long firmware_loading_timeout(void)
>  #define FW_OPT_FALLBACK                0
>  #endif
>  #define FW_OPT_NO_WARN (1U << 3)
> +#define FW_OPT_NOCACHE (1U << 4)

6 days late -- but even if I wasn't Cc'd I caught this on linux-next
-- but please folks

NACK,

We should not be adding *yet another flag* and *yet another new API*
for a mild tweak to the API. The firmware API is already messed up
enough as it is, enough is enough. I'll post v4 of the new flexible
API which after feedback from v3 series [0] should put this to an end.
That should enable you to add your optional needs via a descriptor
without any other collateral evolutins. I had been waiting to push out
v4 until me and Julia completed some SmPL conversion to help drivers
easily convert over but seeing this patch got merged and I think this
can't wait any more, the SmPL grooviness will have to wait a bit and
some simple manual transformation examples will be provided.

[0] http://lkml.kernel.org/r/1450906497-24179-6-git-send-email-mcgrof@do-not-panic.com

  Luis

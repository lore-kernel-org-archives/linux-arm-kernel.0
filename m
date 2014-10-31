From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 31 Oct 2014 12:41:09 +0100
Subject: [PATCH 2/2] mailbox: Don't unnecessarily re-arm the polling timer
In-Reply-To: <1414699267-17970-2-git-send-email-abrestic@chromium.org>
References: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
 <1414699267-17970-2-git-send-email-abrestic@chromium.org>
Message-ID: <20141031114107.GE10778@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 01:01:07PM -0700, Andrew Bresticker wrote:
> poll_txdone() will unconditionally re-arm the polling timer if there was
> an active request, even if the active request completed and no other
> requests were submitted.  This is fixed by:
>  - only re-arming the timer if the controller reported that the current
>    transmission has not completed, and,
>  - moving the call to poll_txdone() into msg_submit() so that the
>    controller gets polled (and the timer re-armed, if necessary) whenever
>    a new message is submitted.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  drivers/mailbox/mailbox.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 5008028..26f74ad 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -28,6 +28,8 @@
>  static LIST_HEAD(mbox_cons);
>  static DEFINE_MUTEX(con_mutex);
>  
> +static void poll_txdone(unsigned long data);

I think I'd rather move poll_txdone() here to avoid the forward
declaration, but either way:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/5002600c/attachment-0001.sig>

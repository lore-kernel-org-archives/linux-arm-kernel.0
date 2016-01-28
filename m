From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 28 Jan 2016 09:54:16 +0530
Subject: [PATCH 1/4] mailbox: mailbox-test: Use more consistent format for
 calling copy_from_user()
In-Reply-To: <1452755489-18736-2-git-send-email-lee.jones@linaro.org>
References: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
 <1452755489-18736-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CABb+yY3jG7XLf-+C5_pK_v7AoKYC2iskpL2=XpkvjPVZZcdCTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 12:41 PM, Lee Jones <lee.jones@linaro.org> wrote:
> While we're at it, ensure copy-to location is NULL'ed in the error path.
>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mailbox/mailbox-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
> index 684ae17..7d9b915 100644
> --- a/drivers/mailbox/mailbox-test.c
> +++ b/drivers/mailbox/mailbox-test.c
> @@ -63,9 +63,9 @@ static ssize_t mbox_test_signal_write(struct file *filp,
>         if (!tdev->signal)
>                 return -ENOMEM;
>
> -       ret = copy_from_user(tdev->signal, userbuf, count);
> -       if (ret) {
> +       if (copy_from_user(tdev->signal, userbuf, count)) {
>                 kfree(tdev->signal);
> +               tdev->signal = NULL;
>                 return -EFAULT;
>         }
>
The function is left to return based on an uninitialized variable
('ret' on stack), so please merge this and the patch 2/4.

Thanks.

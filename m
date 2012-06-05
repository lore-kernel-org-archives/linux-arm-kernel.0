From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 5 Jun 2012 16:09:33 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <1338936900.1157.3.camel@mop>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338936900.1157.3.camel@mop>
Message-ID: <20120605160933.6fd5bc90.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Jun 2012 00:55:00 +0200
Kay Sievers <kay@vrfy.org> wrote:

> On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:
> 
> > devkmsg_writev() does weird and wonderful things with
> > facilities/levels.  That function incorrectly returns "success" when
> > copy_from_user() faults, btw.
> 
> Oh. Better?
> 
> Thanks,
> Kay
> 
> 
> From: Kay Sievers <kay@vrfy.org>
> Subject: kmsg: /dev/kmsg - properly return possible copy_from_user() failure
> 
> Reported-By: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kay Sievers <kay@vrfy.org
> ---
>  printk.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk.c b/kernel/printk.c
> index 32462d2..6bdacab 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -365,8 +365,10 @@ static ssize_t devkmsg_writev(struct kiocb *iocb, const struct iovec *iv,
>  
>  	line = buf;
>  	for (i = 0; i < count; i++) {
> -		if (copy_from_user(line, iv[i].iov_base, iv[i].iov_len))
> +		if (copy_from_user(line, iv[i].iov_base, iv[i].iov_len)) {
> +			ret = -EFAULT;
>  			goto out;
> +		}
>  		line += iv[i].iov_len;
>  	}

Strictly speaking, when write() encounters an error it should return
number-of-bytes-written, or an errno if it wrote zero bytes.  So
something like

--- a/kernel/printk.c~a
+++ a/kernel/printk.c
@@ -355,7 +355,7 @@ static ssize_t devkmsg_writev(struct kio
 	int level = default_message_loglevel;
 	int facility = 1;	/* LOG_USER */
 	size_t len = iov_length(iv, count);
-	ssize_t ret = len;
+	ssize_t ret;
 
 	if (len > LOG_LINE_MAX)
 		return -EINVAL;
@@ -365,8 +365,12 @@ static ssize_t devkmsg_writev(struct kio
 
 	line = buf;
 	for (i = 0; i < count; i++) {
-		if (copy_from_user(line, iv[i].iov_base, iv[i].iov_len))
+		if (copy_from_user(line, iv[i].iov_base, iv[i].iov_len)) {
+			ret = line - buf;
+			if (!ret)
+				ret = -EFAULT;
 			goto out;
+		}
 		line += iv[i].iov_len;
 	}
 
@@ -396,6 +400,7 @@ static ssize_t devkmsg_writev(struct kio
 	line[len] = '\0';
 
 	printk_emit(facility, level, NULL, 0, "%s", line);
+	ret = 0;
 out:
 	kfree(buf);
 	return ret;
_

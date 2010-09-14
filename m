From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Tue, 14 Sep 2010 10:25:06 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <4C8EE708.5000109@codeaurora.org>
References: <4C61EE55.5030506@codeaurora.org>
	<201008251414.16411.arnd@arndb.de>
	<20100825125451.GH2153@osiris.boeblingen.de.ibm.com>
	<201008251555.53653.arnd@arndb.de>
	<20100825144040.GI2153@osiris.boeblingen.de.ibm.com>
	<4C7867D4.10404@codeaurora.org>
	<20100828074304.GA2183@osiris.boeblingen.de.ibm.com>
	<4C81CFEF.6060701@codeaurora.org> <4C8EE708.5000109@codeaurora.org>
Message-ID: <20100914082506.GA2201@osiris.boeblingen.de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 08:07:52PM -0700, Stephen Boyd wrote:
> Ok, I wasn't aware that only x86_32 has support for user copy checks. So
> I hacked support for that on x86_64 and then saw the kprobes.c failure.
> Great! Now for the weird(?) part.
> 
> Changing the buf_size variable from an int to a size_t makes the warning
> go away. Perhaps this is because gcc can't reliably eliminate the else
> case when the lower bound isn't 0? Overflow? I'm not really sure. Does
> the kernel/kprobes.c part of this patch work for you?
> 
[...]
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 282035f..fa4e0f9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1967,7 +1967,7 @@ static ssize_t write_enabled_file_bool(struct file *file,
>  	       const char __user *user_buf, size_t count, loff_t *ppos)
>  {
>  	char buf[32];
> -	int buf_size;
> +	size_t buf_size;
> 
>  	buf_size = min(count, (sizeof(buf)-1));
>  	if (copy_from_user(buf, user_buf, buf_size))

Yes, the warning goes away on s390 as well.

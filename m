From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 23 Nov 2012 05:07:29 +0200
Subject: [RFC][PATCH] printk: add boot_quiet param to support deferred
 printk while booting
In-Reply-To: <1353639022-13273-1-git-send-email-Barry.Song@csr.com>
References: <1353639022-13273-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20121123030729.GB4030@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Fri, Nov 23, 2012 at 10:50:22AM +0800, Barry Song wrote:

[...]

> diff --git a/kernel/printk.c b/kernel/printk.c
> index 2d607f4..0b88d6bf 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -250,6 +250,9 @@ static u32 clear_idx;
>  #define LOG_ALIGN __alignof__(struct log)
>  #endif
>  #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
> +static char __boot_log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);

Since we do not use this buffer when the system is running, is there a way to 
release it once its content has been written to console?

baruch

> +static int boot_log_len;
> +
>  static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
>  static char *log_buf = __log_buf;
>  static u32 log_buf_len = __LOG_BUF_LEN;
> @@ -1247,6 +1250,16 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

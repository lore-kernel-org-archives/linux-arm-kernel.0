From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 25 Aug 2013 17:38:11 +0200
Subject: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
In-Reply-To: <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20130825153811.GA4795@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Use the name_to_dev_t call to parse the device name echo'd to
> to /sys/power/resume.  This imitates the method used in hibernate.c
> in software_resume, and allows the resume partition to be specified
> using other equivalent device formats as well.  By allowing
> /sys/debug/resume to accept the same syntax as the resume=device
> parameter, we can parse the resume=device in the init script and
> use the resume device directly from the kernel command line.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> ---
>  kernel/power/hibernate.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index b26f5f1..51d4c29 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -971,15 +971,19 @@ static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
>  static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>  			    const char *buf, size_t n)
>  {
> -	unsigned int maj, min;
>  	dev_t res;
>  	int ret = -EINVAL;
> +	int len = n;
> +	char *devcpy;
>  
> -	if (sscanf(buf, "%u:%u", &maj, &min) != 2)
> -		goto out;
> +	if (buf[len-1] == '\n')
> +		len--;
> +
> +	devcpy = kstrndup(buf, len, GFP_KERNEL);
> +	res = name_to_dev_t(devcpy);
> +	kfree(devcpy);

Is the allocation actually neccessary? At the very least this should
test for NULL...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

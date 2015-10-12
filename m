From: neilb@suse.com (Neil Brown)
Date: Mon, 12 Oct 2015 15:59:27 +1100
Subject: [PATCH] md: fix 32-bit build warning
In-Reply-To: <5304496.D8N6u074t0@wuerfel>
References: <5304496.D8N6u074t0@wuerfel>
Message-ID: <87fv1g1y34.fsf@notabene.neil.brown.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On 32-bit architectures, the md code produces this warning when CONFIG_LDAF
> is set:
>
> drivers/md/md.c: In function 'check_sb_changes':
> drivers/md/md.c:8990:10: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'sector_t {aka long long unsigned int}' [-Wformat=]
>    pr_info("%s:%d recovery_cp changed from %lu to %lu\n", __func__,
>
> The code was only recently introduced, and uses the wrong format string
> for sector_t. As a workaround, this patch adds an explicit cast to 'u64'
> so we can use the %llu format string on all architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e0212320066e ("md-cluster: Improve md_reload_sb to be less error prone")
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>
> I also noticed that some commmits in md/for-next including the one causing
> the problem lack a Signed-off-by line. It might make sense to just fold this
> patch and add the lines at the same time.
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7fff1e6884d6..e13f72a3b561 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8987,9 +8987,9 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
>  
>  	/* recovery_cp changed */
>  	if (le64_to_cpu(sb->resync_offset) != mddev->recovery_cp) {
> -		pr_info("%s:%d recovery_cp changed from %lu to %lu\n", __func__,
> -				__LINE__, mddev->recovery_cp,
> -				(unsigned long) le64_to_cpu(sb->resync_offset));
> +		pr_info("%s:%d recovery_cp changed from %llu to %llu\n", __func__,
> +				__LINE__, (u64)mddev->recovery_cp,
> +				(u64) le64_to_cpu(sb->resync_offset));
>  		mddev->recovery_cp = le64_to_cpu(sb->resync_offset);
>  	}
>  

Thanks, but is this really right?
I think u64 is "unsigned long" on 64bit.
I have always used (unsigned long long) when I want to use %llu on
sector_t.

How confident are you of using "u64" ?

Thanks,
NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/7ca58da1/attachment.sig>

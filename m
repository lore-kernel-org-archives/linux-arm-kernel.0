From: jack@suse.cz (Jan Kara)
Date: Mon, 8 Oct 2012 13:51:16 +0200
Subject: [PATCH 05/16] vfs: bogus warnings in fs/namei.c
In-Reply-To: <1349448930-23976-6-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <1349448930-23976-6-git-send-email-arnd@arndb.de>
Message-ID: <20121008115116.GA9243@quack.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 05-10-12 16:55:19, Arnd Bergmann wrote:
> The follow_link() function always initializes its *p argument,
> or returns an error, but not all versions of gcc figure this
> out, so we have to work around this using the uninitialized_var()
> macro.
  Well, I'm somewhat sceptical to this approach. I agree that bogus
warnings are not nice but later when the code is changed and possibly real
use without initialization is added, we won't notice it. Without changing
anything, we'd at least have a chance of catching it with gcc versions
which were clever enough to not warn with the original code. Or
alternatively if we unconditionally initialized the variable that would get
rid of the warning and made the code more future-proof (that's what I
usually end up doing)... I don't really care that much about the chosen
solution, Al is the one to decide. But I wanted to point out there are
downsides to your solution.

								Honza

> 
> Without this patch, building with arm-linux-gnueabi-gcc-4.6 results in:
> 
> fs/namei.c: In function 'link_path_walk':
> fs/namei.c:649:24: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]
> fs/namei.c:1544:9: note: 'cookie' was declared here
> fs/namei.c: In function 'path_lookupat':
> fs/namei.c:649:24: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]
> fs/namei.c:1934:10: note: 'cookie' was declared here
> fs/namei.c: In function 'path_openat':
> fs/namei.c:649:24: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]
> fs/namei.c:2899:9: note: 'cookie' was declared here
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel at vger.kernel.org
> Cc: Jan Kara <jack@suse.cz>
> ---
>  fs/namei.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index dd1ed1b..62a1725 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1543,7 +1543,7 @@ static inline int nested_symlink(struct path *path, struct nameidata *nd)
>  
>  	do {
>  		struct path link = *path;
> -		void *cookie;
> +		void *uninitialized_var(cookie);
>  
>  		res = follow_link(&link, nd, &cookie);
>  		if (res)
> @@ -1933,7 +1933,7 @@ static int path_lookupat(int dfd, const char *name,
>  	if (!err && !(flags & LOOKUP_PARENT)) {
>  		err = lookup_last(nd, &path);
>  		while (err > 0) {
> -			void *cookie;
> +			void *uninitialized_var(cookie);
>  			struct path link = path;
>  			err = may_follow_link(&link, nd);
>  			if (unlikely(err))
> @@ -2902,7 +2902,7 @@ static struct file *path_openat(int dfd, const char *pathname,
>  	error = do_last(nd, &path, file, op, &opened, pathname);
>  	while (unlikely(error > 0)) { /* trailing symlink */
>  		struct path link = path;
> -		void *cookie;
> +		void *uninitialized_var(cookie);
>  		if (!(nd->flags & LOOKUP_FOLLOW)) {
>  			path_put_conditional(&path, nd);
>  			path_put(&nd->path);
> -- 
> 1.7.10
> 
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR

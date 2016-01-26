From: rpeterso@redhat.com (Bob Peterson)
Date: Tue, 26 Jan 2016 14:08:13 -0500 (EST)
Subject: [PATCH] gfs2: avoid uninitialized variable warning
In-Reply-To: <1453735996-1958733-2-git-send-email-arnd@arndb.de>
References: <1453735996-1958733-1-git-send-email-arnd@arndb.de>
 <1453735996-1958733-2-git-send-email-arnd@arndb.de>
Message-ID: <1232643434.15889153.1453835293754.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message -----
> We get a bogus warning about a potential uninitialized variable
> use in gfs2, because the compiler does not figure out that we
> never use the leaf number if get_leaf_nr() returns an error:
> 
> fs/gfs2/dir.c: In function 'get_first_leaf':
> fs/gfs2/dir.c:802:9: warning: 'leaf_no' may be used uninitialized in this
> function [-Wmaybe-uninitialized]
> fs/gfs2/dir.c: In function 'dir_split_leaf':
> fs/gfs2/dir.c:1021:8: warning: 'leaf_no' may be used uninitialized in this
> function [-Wmaybe-uninitialized]
> 
> Changing the 'if (!error)' to 'if (!IS_ERR_VALUE(error))' is
> sufficient to let gcc understand that this is exactly the same
> condition as in IS_ERR() so it can optimize the code path enough
> to understand it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/gfs2/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 6a92592304fb..d4014af4f064 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -798,7 +798,7 @@ static int get_first_leaf(struct gfs2_inode *dip, u32
> index,
>  	int error;
>  
>  	error = get_leaf_nr(dip, index, &leaf_no);
> -	if (!error)
> +	if (!IS_ERR_VALUE(error))
>  		error = get_leaf(dip, leaf_no, bh_out);
>  
>  	return error;
> @@ -1014,7 +1014,7 @@ static int dir_split_leaf(struct inode *inode, const
> struct qstr *name)
>  
>  	index = name->hash >> (32 - dip->i_depth);
>  	error = get_leaf_nr(dip, index, &leaf_no);
> -	if (error)
> +	if (IS_ERR_VALUE(error))
>  		return error;
>  
>  	/*  Get the old leaf block  */
> --
> 2.7.0
> 
> 
Hi,

Thanks. This is now applied to the for-next branch of the linux-gfs2 tree:
https://git.kernel.org/cgit/linux/kernel/git/gfs2/linux-gfs2.git/commit/fs/gfs2?h=for-next&id=07cfdc3071432a07713e4d007c2811e0224490b0

Regards,

Bob Peterson
Red Hat File Systems

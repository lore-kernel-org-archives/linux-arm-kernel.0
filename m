From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 23 Oct 2013 12:43:33 +0200
Subject: userspace firmware load fails with current linux-next
In-Reply-To: <20131023182609.6646b5c0@tom-ThinkPad-T410>
References: <20131023110618.7bd07899@ipc1.ka-ro>
 <20131023182609.6646b5c0@tom-ThinkPad-T410>
Message-ID: <20131023124333.356d0e15@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ming Lei wrote:
> On Wed, 23 Oct 2013 11:06:18 +0200
> Lothar Wa?mann <LW@KARO-electronics.de> wrote:
> 
[...]
> > Or is it an unintended side effect of some recent change?
> 
> Maybe yes, could you test below patch?
> 
> Tejun, looks we need to keep special attention on zero size of bin file
> as before, could you comment at the patch?
> 
> --
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 5d818df..366ae8d 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -277,7 +277,7 @@ static ssize_t sysfs_write_file(struct file *file, const char __user *user_buf,
>  	ssize_t len = min_t(size_t, count, PAGE_SIZE);
>  	char *buf;
>  
> -	if (sysfs_is_bin(of->sd)) {
> +	if (sysfs_is_bin(of->sd) && size) {
>  		loff_t size = file_inode(file)->i_size;
>  
>  		if (size <= *ppos)
> 
> 
> 
The patch as is produces a build error, because 'size' is only defined
after the 'if' statement.

The modified patch below works for me.

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 5d818df..709d6f5 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -277,7 +277,7 @@ static ssize_t sysfs_write_file(struct file *file, const char __user *user_buf,
 	ssize_t len = min_t(size_t, count, PAGE_SIZE);
 	char *buf;
 
-	if (sysfs_is_bin(of->sd)) {
+	if (sysfs_is_bin(of->sd) && file_inode(file)->i_size) {
 		loff_t size = file_inode(file)->i_size;
 
 		if (size <= *ppos)



Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________

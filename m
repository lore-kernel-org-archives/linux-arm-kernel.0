From: FuXinRong@skyworth.com (=?gb2312?B?uLbQwsjZ?=)
Date: Mon, 19 Oct 2009 17:57:21 +0800
Subject: About the system call named "sys_mount".
Message-ID: <1C70663C229ECE40981BAC25C6482BC4072EABEA@SZHOMailBE01.skyworth.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, every body:

the "sys_mount" function allocates a block of memory whose size is 4096 bytes through buddy system(__get_free_page) or slab system(kmem_cache_alloc)  for every parameters,  then copy the parameters to the memory from user space.
the copy process of parameters is accomplished in "getname" and "copy_mount_options" functions. 
  
now, i want to simplify the function according to the following method, but i don't know wether there is some potential risk.
1. don't to allocates memory in kernel space for each parameter.
2. sys_mount refer to the parameter through the memory pointer passed directly.

kernel version: 2.6.14
hard platform: ARM926ejs

the modified source of "sys_mount" function as following:
asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
     char __user * type, unsigned long flags,
     void __user * data)
{
 int retval;
 unsigned long data_page;
 unsigned long type_page;
 unsigned long dev_page;
 char *dir_page;
/* the first modification, comment the following code.
 retval = copy_mount_options (type, &type_page);
 if (retval < 0)
  return retval;
 dir_page = getname(dir_name);
 retval = PTR_ERR(dir_page);
 if (IS_ERR(dir_page))
  goto out1;
 retval = copy_mount_options (dev_name, &dev_page);
 if (retval < 0)
  goto out2;
 retval = copy_mount_options (data, &data_page);
 if (retval < 0)
  goto out3;
*/
 lock_kernel();
/* the second modification, refer to the parameters by memory pointer inputed directly  */
#if 0
 retval = do_mount((char*)dev_page, dir_page, (char*)type_page,
     flags, (void*)data_page);
#else
 retval = do_mount((char*)dev_name, dir_name, (char*)type, flags, (void*)data);
#endif
 unlock_kernel();
/*
 free_page(data_page);
out3:
 free_page(dev_page);
out2:
 putname(dir_page);
out1:
 free_page(type_page);
*/
 return retval;
}
if there is no potential risk, the speed of "mount" command would be improved greatly. 
Tell me plz if there is problem. thax.

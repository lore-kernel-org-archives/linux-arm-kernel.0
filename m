From: fxinrong@hotmail.com (sean fu)
Date: Thu, 29 Oct 2009 17:54:15 +0800
Subject: about  the parameter passing of system call.
Message-ID: <COL116-W14008DD23BCD96DE47218DC2B70@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


i think the copy of parameters aren't necessary in the "sys_mount" function.because the following two reasons:1. when the software interrupt occurs, the C2 register of CP15 have no change, IOW, the page table of  current task is used by MMU at this time, this page table include the mapping of kernel space and the mapping of current task.?2. the priority of  data abort interrupt is higher than the software interrupt. then we don't worry the data is swapped.?

in detail, the "sys_mount" function allocates a block of memory whose size is 4096 bytes through buddy system(__get_free_page) or slab system(kmem_cache_alloc)  for every parameter,  then copy this parameters to the memory from user space.the copy process of parameters is accomplished in "getname" and "copy_mount_options" functions.now, i want to simplify the function according to the following method:1. don't to allocates memory in kernel space for each parameter.2. sys_mount refer to the parameter through the memory pointer passed directly.

kernel version: 2.6.14hard platform: ARM926ejs
the modified source of "sys_mount" function as following:
asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,?? ? ? ? ? ? ? ? ? ? ? ? ?char __user * type, unsigned long flags,?? ? ? ? ? ? ? ? ? ? ? ? ?void __user * data){?? ? ? ?int retval;?? ? ? ?unsigned long data_page;?? ? ? ?unsigned long type_page;?? ? ? ?unsigned long dev_page;?? ? ? ?char *dir_page;/*?? ? ? ?retval = copy_mount_options (type, &type_page);?? ? ? ?if (retval < 0)?? ? ? ? ? ? ? ?return retval;
?? ? ? ?dir_page = getname(dir_name);?? ? ? ?retval = PTR_ERR(dir_page);?? ? ? ?if (IS_ERR(dir_page))?? ? ? ? ? ? ? ?goto out1;
?? ? ? ?retval = copy_mount_options (dev_name, &dev_page);?? ? ? ?if (retval < 0)?? ? ? ? ? ? ? ?goto out2;
?? ? ? ?retval = copy_mount_options (data, &data_page);?? ? ? ?if (retval < 0)?? ? ? ? ? ? ? ?goto out3;*/	lock_kernel();#if 0	retval = do_mount((char*)dev_page, dir_page, (char*)type_page,?? ? ? ? ? ? ? ? ? ? ? ? ?flags, (void*)data_page);#else?? ? ? retval = do_mount((char*)dev_name, dir_name, (char*)type, flags, (void*)data);#endif?? ? ? ?unlock_kernel();/*?? ? ? ?free_page(data_page);
out3:?? ? ? ?free_page(dev_page);out2:?? ? ? ?putname(dir_page);out1:?? ? ? ?free_page(type_page);*/
// End of Modify by fuxinrong, 2009-10-19?? ? ? ?return retval;}
if there is no potential risk, the speed of "mount" command would be improved greatly. Tell me plz if there is problem. thax.
 		 	   		  
_________________________________________________________________
Windows Live: Make it easier for your friends to see what you?re up to on Facebook.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_2:092009

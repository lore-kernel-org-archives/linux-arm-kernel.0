From: dann.frazier@canonical.com (dann frazier)
Date: Mon, 23 Oct 2017 19:47:54 -0600
Subject: [bug report] regression bisected to "block: Make most
 scsi_req_init() calls implicit"
In-Reply-To: <1508792914.2634.6.camel@wdc.com>
References: <20171020225420.utvoqmtwit2isalc@xps13.dannf>
 <1508542254.3029.24.camel@wdc.com>
 <20171023154129.iik3ic36i5fi7sqs@xps13.dannf>
 <1508792914.2634.6.camel@wdc.com>
Message-ID: <CALdTtnuL6_Tc5QF79xrGvxT+FAJrWN4MK++d7b4+QjPktcQdcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 3:08 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Mon, 2017-10-23 at 09:41 -0600, dann frazier wrote:
>> (gdb) list *(sg_io+0x120)
>> 0xffff0000084e71a8 is in sg_io (./include/linux/uaccess.h:113).
>> 108   static inline unsigned long
>> 109   _copy_from_user(void *to, const void __user *from, unsigned long n)
>> 110   {
>> 111           unsigned long res = n;
>> 112           might_fault();
>> 113           if (likely(access_ok(VERIFY_READ, from, n))) {
>> 114                   kasan_check_write(to, n);
>> 115                   res = raw_copy_from_user(to, from, n);
>> 116           }
>> 117           if (unlikely(res))
>
> Hello Dann,
>
> Would it be possible to check whether the patch below is sufficient to fix this?

hey Bart,
 Yes, it does appear to be sufficient:

ubuntu at ubuntu:~$ sudo dmesg -c > /dev/null
ubuntu at ubuntu:~$ sudo dmraid -r -c
ERROR: isw: seeking device "/dev/vda" to 18446744073708843520
ERROR: sil: seeking device "/dev/vda" to 18446744073709401600
no raid disks
ubuntu at ubuntu:~$ dmesg
ubuntu at ubuntu:~$

  -dann

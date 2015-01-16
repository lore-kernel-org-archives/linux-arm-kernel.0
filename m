From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 16 Jan 2015 12:48:11 -0500
Subject: [RFC PATCH 00/11] Early kprobe: enable kprobes at very early
In-Reply-To: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
References: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20150116174811.GA7817@home.goodmis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 03:34:46PM +0800, Wang Nan wrote:
> 
> Patch 10 enables cmdline option 'ekprobe=', allows setup probe at
> cmdline. However, currently the kprobe handler is only a simple printk.
> 
> Patch 11 introduces required Kconfig options to actually enable early
> kprobes.
> 
> Usage of early kprobe is as follow:
> 
> Booting kernel with cmdline 'ekprobe=', like:
> 
> ... rdinit=/sbin/init ekprobe=0xc00f3c2c ekprobe=__free_pages ...

Perhaps you should specify what the probe will do. For now it is only printk.
For example:

  ekprobe=printk,__free_pages

That is, here you are attaching a printk to __free_pages.

Later, when you implement tracing, you could have:

 ekprobe=trace,__free_pages

where it will be sent to the ring buffer.

This will maintain backward compatibility when you add new features. Instead
of getting something like printk working now, and people use it for such,
and then when you switch it over to tracing, it breaks the printk version.

Also, if you plan on converting early kprobes to normal kprobes during boot,
then it should just be kprobes=..., why add the 'e'. It being early is just
an implementation detail, not something that should be expressed by the users
of the facility.

-- Steve


> 
> During boot, kernel will print trace using printk:
> 
>  ...
>  Hit early kprobe at __alloc_pages_nodemask+0x4
>  Hit early kprobe at __free_pages+0x0
>  Hit early kprobe at __alloc_pages_nodemask+0x4
>  Hit early kprobe at __free_pages+0x0
>  Hit early kprobe at __free_pages+0x0
>  Hit early kprobe at __alloc_pages_nodemask+0x4
>  ...

From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 3 Mar 2014 10:51:23 +0800
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <20140228163304.GA15614@kroah.com>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
 <53104ECA.4010702@freescale.com>
 <35FD53F367049845BC99AC72306C23D102844605F38D@CNBJMBX05.corpusers.net>
 <20140228163304.GA15614@kroah.com>
Message-ID: <35FD53F367049845BC99AC72306C23D102844605F38F@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  greg,

I am sorry,
I make a mistake ,
You are right ,
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/usb/gadget/f_mass_storage.c?h=master#n2724

this one should not changed to use vmalloc,
the buffer will be used by DMA?

others should be safe to change:

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/sound/soc/soc-core.c?h=master#n3772

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_ftp.c?h=master#n603
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_h323_main.c?h=master#n1849
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_irc.c?h=master#n247
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_sane.c?h=master#n195

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/input/evdev.c?h=master#n403


Thanks 
-----Original Message-----
From: 'gregkh@linuxfoundation.org' [mailto:gregkh at linuxfoundation.org] 
Sent: Saturday, March 01, 2014 12:33 AM
To: Wang, Yalin
Cc: 'Huang Shijie'; 'linux-kernel at vger.kernel.org'; 'linux-arm-msm at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-input at vger.kernel.org'; 'balbi at ti.com'; 'lrg at ti.com'; 'broonie at opensource.wolfsonmicro.com'; 'perex at perex.cz'; 'tiwai at suse.de'; 'pablo at netfilter.org'; 'kaber at trash.net'; 'davem at davemloft.net'; 'rostedt at goodmis.org'; 'fweisbec at gmail.com'; 'mingo at redhat.com'; 'dmitry.torokhov at gmail.com'; 'rydberg at euromail.se'; 'linux-usb at vger.kernel.org'; 'alsa-devel at alsa-project.org'; 'netfilter-devel at vger.kernel.org'; 'netfilter at vger.kernel.org'; 'coreteam at netfilter.org'; 'netdev at vger.kernel.org'
Subject: Re: change kmalloc into vmalloc for large memory allocations

On Fri, Feb 28, 2014 at 05:20:08PM +0800, Wang, Yalin wrote:
> Hi
> 
> 
> Yeah,
> Dma buffer must be allocated by kmalloc,
> 
> But the modules I list should can all be changed to use vmalloc, 
> because the buffer is only used by software, Not by any hardware .

Are you sure about that?  The USB gadget driver needs DMA memory from what I can tell, have you tried your change out on a system that does not allow the USB controller to access non-DMA memory?

And I agree with Steve, just fix the individual drivers, don't do a "hidden" change of where the memory is allocated from, that's not a good idea and will cause problems later.

greg k-h

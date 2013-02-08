From: mats.liljegren@enea.com (Mats Liljegren)
Date: Fri, 8 Feb 2013 20:10:23 +0100
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
In-Reply-To: <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
References: <20130204200238.GA16718@enea.se>
 <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
Message-ID: <20130208191023.GB30150@enea.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker wrote:
> 2013/2/4 Mats Liljegren <mats.liljegren@enea.com>:
> > Hi Frederic,
> >
> > (Sorry for the re-post, I spelled the mailing list wrong...)
> >
> > I want to port dynticks patches 3.8-rc4-nohz3 to ARM architecture, and try it out on the PandaBoard. Initially this is for evaluating it, but if it looks promising I'd like to upstream this.
> >
> > As far as I can see the first thing to do is to implement virtual time accounting. After an initial look at the patches done for ia64, it doesn't look too difficult.
> 
> No that part is handled by the core code. But you need to implement
> the context tracking arch backend.
> Here is what Li Zhong did to port it on Powerpc for example:
> https://lkml.org/lkml/2013/2/1/216
> 
> > Are there any caveats I should be aware of?
> 
> The generic cputime accounting only works on 64 bits archs. We'll need
> to do some safe accessors to read the kernel_stat. In the meantime you
> can do home tests by removing the CONFIG_64BIT dependency. This
> shouldn't be dangerous
> 
> > Has anyone else started any work in this area that I could co-operate with?
> 
> Yeah two people have been working on this. But it was several month
> ago and I haven't hear from them since then. I'm adding Geoff in Cc. I
> can't retrieve the other guy who has worked on it too.

Thanks for the hints! They helped me along the way.

I have now managed to boot Linux without getting RCU complaints with RCU
checking enabled. I enabled virtual CPU accounting by ignoring 64BIT
dependency, as you suggested. I had to add an __aeabi_uldivmod function to
get it to compile though.

It boots without RCU complaints when CONFIG_PROVE_RCU is enabled.

Next step will be to figure out those boot parameters to enable full
dynticks mode, and see whether I forgot something... ;-) I'll do so on Monday.

Regards
Mats Liljegren

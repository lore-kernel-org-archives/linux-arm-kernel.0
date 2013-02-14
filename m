From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 14 Feb 2013 15:08:02 -0800
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
In-Reply-To: <20130211190317.GA8513@enea.se> (Mats Liljegren's message of
 "Mon, 11 Feb 2013 20:03:17 +0100")
References: <20130204200238.GA16718@enea.se>
 <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
 <20130211190317.GA8513@enea.se>
Message-ID: <874nhea3zh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mats Liljegren <mats.liljegren@enea.com> writes:

> Frederic Weisbecker wrote:
>> 2013/2/4 Mats Liljegren <mats.liljegren@enea.com>:
>> > Hi Frederic,
>> >
>> > (Sorry for the re-post, I spelled the mailing list wrong...)
>> >
>> > I want to port dynticks patches 3.8-rc4-nohz3 to ARM architecture,
>> > and try it out on the PandaBoard. Initially this is for evaluating
>> > it, but if it looks promising I'd like to upstream this.
>> >
>> > As far as I can see the first thing to do is to implement virtual
>> > time accounting. After an initial look at the patches done for
>> > ia64, it doesn't look too difficult.
>> 
>> No that part is handled by the core code. But you need to implement
>> the context tracking arch backend.
>> Here is what Li Zhong did to port it on Powerpc for example:
>> https://lkml.org/lkml/2013/2/1/216
>> 
>> > Are there any caveats I should be aware of?
>> 
>> The generic cputime accounting only works on 64 bits archs. We'll need
>> to do some safe accessors to read the kernel_stat. In the meantime you
>> can do home tests by removing the CONFIG_64BIT dependency. This
>> shouldn't be dangerous
>> 
>> > Has anyone else started any work in this area that I could co-operate with?
>> 
>> Yeah two people have been working on this. But it was several month
>> ago and I haven't hear from them since then. I'm adding Geoff in Cc. I
>> can't retrieve the other guy who has worked on it too.
>
> Could the other guy be Kevin Hillman? 

Yup, that's him (though my last name has only one 'l' ;)

> The name has been mentioned to me but I don't have his e-mail address.

Now you do. :)

After some time away, I'm back to working on getting adaptive nohz
working on ARM, but things have changed quite a bit since I last worked
on it.  Things actually look a bit simpler now with the new
context_tracking layer, but that needs a little work for ARM which I'm
now looking into.

However, just to get things compiling needs a little work too.  I've
setup a work-in-progress branch which you can start from to at least get
things compiling[1].

I noticed you already ran accross the 64-bit division problem.  I've
proposed a patch for that[2] which is included in my branch along with a
few other things.

Hope that helps,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git wip/3.8-rc6-nohz4-arm
[2] http://marc.info/?l=linux-kernel&m=136087139214252&w=2

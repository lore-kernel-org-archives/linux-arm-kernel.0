From: danielmicay@gmail.com (Daniel Micay)
Date: Mon, 08 May 2017 11:22:12 -0400
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170508075209.7aluvpwildw325rf@gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508075209.7aluvpwildw325rf@gmail.com>
Message-ID: <1494256932.1167.1.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-05-08 at 09:52 +0200, Ingo Molnar wrote:
> 
> ... it's just not usable in that form for a regular maintenance flow.
> 
> So what would be more useful is to add a specific Sparse check that
> only checks?
> KERNEL_DS, to add it as a regular (.config driven) build option and
> make sure the?
> kernel build has zero warnings.
> 
> From that point on we can declare that this kind of bug won't occur
> anymore, if?
> the Sparse implementation of the check is correct.
> 
> But there's a (big) problem with that development model: Sparse is not
> part of the?
> kernel tree and adding a feature to it while making the kernel depend
> on that?
> brand new feature is a logistical nightmare. The overhead is quite
> similar to?
> adding new features to a compiler - it happens at a glacial pace and
> is only done?
> for major features really, at considerable expense. I don't think this
> is an?
> adequate model for 'extended syntax checking' of the kernel,
> especially when it?
> comes to correctness that has such obvious security impact.
> 
> Thanks,
> 
> 	Ingo

There's the option of using GCC plugins now that the infrastructure was
upstreamed from grsecurity. It can be used as part of the regular build
process and as long as the analysis is pretty simple it shouldn't hurt
compile time much.

The problem with doing that is I don't think there are people with much
experience with GCC contributing upstream and it's going to be more work
to develop/maintain than some kind of specialized DSL for analysis. I
think a few static analysis plugins are used as part of maintaining
grsecurity for solving issues like finding false positives for the
REFCOUNT overflow checking feature, so it's something that's already
being done in practice elsewhere.

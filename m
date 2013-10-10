From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Thu, 10 Oct 2013 16:39:19 -0700
Subject: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
In-Reply-To: <878uy0u4j2.fsf@tw-ebiederman.twitter.com>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
 <878uy0u4j2.fsf@tw-ebiederman.twitter.com>
Message-ID: <20131010233919.27645.5526@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Eric W. Biederman (2013-10-10 15:47:45)
> Sebastian Capella <sebastian.capella@linaro.org> writes:
> 
> > Quoting Sebastian Capella (2013-10-03 16:47:35)
> >> Quoting Sebastian Capella (2013-10-03 14:42:46)
> >> > Quoting Andrew Morton (2013-10-03 14:15:23)
> >> > > On Thu,  3 Oct 2013 14:10:37 -0700 Sebastian Capella <sebastian.capella@linaro.org> wrote:
> >> > > 
> >> > > > Enhance name_to_dev_t to handle trailing newline characters
> >> > > > on device paths.  Some inputs to name_to_dev_t may come from
> >> > > > userspace where oftentimes a '\n' is appended to the path.
> >> > > > Added const to the name buffer in both the function
> >> > > > declaration and the prototype to reflect input buffer
> >> > > > handling.
> >> > > > 
> >> > > > By handling trailing newlines in name_to_dev_t, userspace
> >> > > > buffers may be directly passed to name_to_dev_t without
> >> > > > modification.
> >> > > 
> >> > > We have lib/string.c:strim() - perhaps this patch would be
> >> > > neater if it were to use it?
> >> > 
> >> > I was intending to respect the const handling of the input buffer.
> >> > 
> >> I looked into removing the const from the store function, but I'm not sure
> >> this is the right idea, so I'm going to shelf that for now.
> >> 
> >> Please let me know your thoughts.
> >> 
> What is wrong with requiring userspace to use echo -n ?
> 
> That by far seems the simplest and least error prone solution.
> 
> Eric
Trimmed back some of the history above.

Hi Eric,

Thanks for your comment.  While this does solve the problem for that case,
I haven't generally seen sysfs files requiring 'echo -n' before.
If you look in kernel/power/main.c, you can see that in other cases where
you're echoing a string onto a sysfs file, the code will handle the \n.  

I expect it would likely be confusing for users.  The net effect would
be that if you omit the -n, it report something like:
write error: Invalid argument
as if you'd mistyped the resume file.

Thanks,

Sebastian

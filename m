From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Thu, 03 Oct 2013 14:42:46 -0700
Subject: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
In-Reply-To: <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
Message-ID: <20131003214246.24540.99218@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andrew Morton (2013-10-03 14:15:23)
> On Thu,  3 Oct 2013 14:10:37 -0700 Sebastian Capella <sebastian.capella@linaro.org> wrote:
> 
> > Enhance name_to_dev_t to handle trailing newline characters
> > on device paths.  Some inputs to name_to_dev_t may come from
> > userspace where oftentimes a '\n' is appended to the path.
> > Added const to the name buffer in both the function
> > declaration and the prototype to reflect input buffer
> > handling.
> > 
> > By handling trailing newlines in name_to_dev_t, userspace
> > buffers may be directly passed to name_to_dev_t without
> > modification.
> 
> We have lib/string.c:strim() - perhaps this patch would be
> neater if it were to use it?

Hi Morton,

I was intending to respect the const handling of the input buffer.

The actual buffer in this case is not really const as it comes from
the file buffering, but removing the const requires changing the
store function defined in the kobj_attribute, and would propagate
to many areas in the kernel.

Modifying the buffer and removing the const was also suggested by Pavel.
After some discussion I posted this version which did not change the
buffer or the prototype.

Please let me know if the preference is to modify the store function
definition.

I'll prepare a patchset that removes the consts to see how much is
changed.

Thanks,

Sebastian

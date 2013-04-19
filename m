From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 11:11:31 +0100
Subject: [PATCH v4] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <CAD=FV=UddWM=yc5N9=jwbMDpZ7Bpg7o3Z714CnBSg=iHhmPxWw@mail.gmail.com>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
 <CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
 <CAD=FV=UddWM=yc5N9=jwbMDpZ7Bpg7o3Z714CnBSg=iHhmPxWw@mail.gmail.com>
Message-ID: <20130419101131.GH14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 06:56:48AM -0700, Doug Anderson wrote:
> Thomas,
> 
> On Wed, Apr 10, 2013 at 5:48 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> > The call to regulator_enable() is prior to the call to mmc_add_host().
> > Hence, call to mmc_fre_host is not required in this case. So the above
> > change should be right.
> 
> Are you sure that mmc_free_host() is the opposite of mmc_add_host()
> and not mmc_alloc_host()?

mmc_free_host() undoes mmc_alloc_host().  mmc_remove_host() undoes
mmc_add_host().

alloc
add
remove
free

is pretty standard terminology, standard ordering.  If add fails, then
free is the right thing to call to clean up after the alloc.

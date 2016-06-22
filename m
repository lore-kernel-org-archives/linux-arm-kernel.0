From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 22 Jun 2016 09:21:36 -0700
Subject: [STLinux Kernel] [PATCH 4/5] remoteproc: core: Supply framework
 to request, declare and fetch shared memory
In-Reply-To: <5768EDD3.3050203@st.com>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
 <20160615220629.GW1256@tuxbot> <5768EDD3.3050203@st.com>
Message-ID: <20160622162136.GP1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 21 Jun 00:33 PDT 2016, loic pallardy wrote:

> 
> 
> On 06/16/2016 12:06 AM, Bjorn Andersson wrote:
> >On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:
> >
> >>Normally used for management of; carveout, devmem and trace memory.
> >>
> >>Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>---
> >>  drivers/remoteproc/remoteproc_core.c | 174 +++++++++++++++++++++++++++++++++--
> >>  1 file changed, 167 insertions(+), 7 deletions(-)
> >>
> [..]
> >>+}
> >>+EXPORT_SYMBOL(rproc_subdev_add);
> >
> Hi Bjorn,
> 

Hi Loic, thanks for your answer.

> >I worked up a prototype that allows remoteproc drivers to
> >programmatically specify carveout resources, which then are matched and
> >merged with entires from the resource table. I've given these
> >programmatically allocated carveouts a device so that the associated
> >allocation comes out of the specified region - or the rproc region if no
> >match is found.
> >
> No sure to catch your exact use case, but let me try to explain what we have
> today.
> There are different rproc in ST. Some request a large chunk of memory for
> code and data, some have several dedicated memories like IRAM and DRAM.
> In that case carevout memories are defined as subdev (like vrings).
> Association is done thanks to carevout name in firmware resource table (in
> rproc_handle_carveout).
> 

With the proposed solution you will only be able to have a single subdev
defining the "carveout" segment. I have a similar setup where I have two
disjoint memory regions that I would like to carve out memory from.

Further more, I don't have a resource table in my firmware, so I would
like to be able to register these carveout regions programmatically.

> Moreover, as our coprocessors have no iommu, we add some check on allocated
> buffer to verify it fit with resource table declaration (pa).
> This allows to guarantee complete alignment between resources needed by
> firmware and ones allocated by Linux kernel.

I have memory-regions defined in devicetree representing where my
carveouts should be, so the subdev proposal gives me a way to control
the physical placing of the carveout.


So, based on these "requirements" I had in working a patchset that
allows me to register carveout sections programatically and during the
load of the resource table I can merge carveouts (and the other
resources) to form the complete picture.


But this would imply a 1-to-1 relationship between programmatically
defined carveouts and carveouts from the resource table. Would you be
able to handle this? Or do you depend on being able to have your subdev
define the span and then a set of resources fill this up?

Regards,
Bjorn

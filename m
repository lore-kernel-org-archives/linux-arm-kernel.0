From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 11 Aug 2016 13:20:36 -0700
Subject: [PATCH 6/9] remoteproc: core: Add function to append a new
 resource table entry
In-Reply-To: <57AC2E64.9010209@st.com>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-7-lee.jones@linaro.org>
 <57AC2E64.9010209@st.com>
Message-ID: <20160811202036.GC26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 11 Aug 00:51 PDT 2016, loic pallardy wrote:

> Hi Lee,
> 

Loic, please don't top-post.

> I just tested your series and found issue with append mechanism.
> There is no problem to add resources when working on Linux side, but the
> resource table is growing and when copying it at loaded location (ie
> overwriting existing prebuilt resource table of firmware), you have an
> overflow corrupting part of firmware code.
> 

Suman brought up the same concern. For one it shows that we must check
the size of the .resource_table to know if we can fit an expanded table
before installing it.

> Moreover firmware code is in general tuned to a feature set. Resource table
> is created according to supported features. In most of the cases, new
> resource won't be handled by firmware.
> 

For the case behind this implementation, where you have resource
information from e.g. DT and build up a resource table (to be installed)
from that, how would you deal with this? Would you build your firmware
with room for some amount of resources?



As my (not the maintainer-me) need for this is purely on the Linux side
I originally envisioned something where we during firmware load parse
the resource_table into some Linux side data structures; we would allow
for these to be merged with additional data or new ones added and Linux
would handle these.

At the end we would have modified the referenced resource_table (through
references as it isn't the primary data structure) and could copy this.

Or alternatively, in the case you described with an empty start and
resources only from DT, we could have a resource-table-installer that
would make up a resource table from these Linux-side lists of resources.


This path would solve the case that we would not automatically grow the
table with new resources, but for the case where we generate a resource
table at the end we would still have the same issues to conclude on.

Regards,
Bjorn

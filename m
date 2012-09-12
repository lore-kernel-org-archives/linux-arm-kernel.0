From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 12 Sep 2012 18:54:27 -0400
Subject: [PATCH v2] /dev/mem: use phys_addr_t for physical addresses
In-Reply-To: <20120912181503.GB12840@kroah.com>
References: <1347473158-7219-1-git-send-email-cyril@ti.com>
 <20120912181503.GB12840@kroah.com>
Message-ID: <505112A3.7080703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On 9/12/2012 2:15 PM, Greg KH wrote:
> On Wed, Sep 12, 2012 at 02:05:58PM -0400, Cyril Chemparathy wrote:
>> This patch fixes the /dev/mem driver to use phys_addr_t for physical
>> addresses.  This is required on PAE systems, especially those that run
>> entirely out of >4G physical memory space.
>
> What is the symptom if this patch is not applied?  Does it need to be
> backported to older kernels?  If so, which ones?
>

As far as I can tell, this change only benefits platforms where lowmem 
lies outside the 32-bit addressable range.  On the ARM based KeyStone 
platform, all of our memory is located above the 4GB limit at 
0x8:0000:0000.  On this platform, trying to read lowmem breaks as follows:

# dd if==/dev/mem of=/dev/null bs==4k count=1 skip=8388608
dd: /dev/mem: Bad address

Assuming that we are unique in this regard (i.e. lowmem outside 4GB), I 
don't see any reason to backport this to earlier kernels.

-- 
Thanks
- Cyril

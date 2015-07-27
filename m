From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 27 Jul 2015 16:26:03 -0700
Subject: [PATCH v2 08/25] arch: introduce memremap()
In-Reply-To: <20150727051258.GB15836@lst.de>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023842.8664.97620.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150726172527.GA29513@lst.de>
 <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
 <20150727051258.GB15836@lst.de>
Message-ID: <CAPcyv4jN6jYzw11qOOR-xd_w6s5dguQSoHyvmPFSWtL9S+tz3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 10:12 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Jul 26, 2015 at 10:49:39AM -0700, Dan Williams wrote:
>> On Sun, Jul 26, 2015 at 10:25 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > On Fri, Jul 24, 2015 at 10:38:42PM -0400, Dan Williams wrote:
>> >> The behavior change to return NULL on an unsupported request is reserved
>> >> for a later patch.
>> >
>> > Why?
>>
>> This is for drivers like pmem that care about the mapping type.  For
>> example, if pmem can't get a cache-enabled mapping it is potentially
>> putting the write durability of the persistent media at risk.
>
> I understand that part, but the question is why the old behavior
> is retained for now and only changed later.

Oh, because all we have at this point is ioremap_cache() which
silently falls back.  It's not until the introduction of
arch_memremp() where we update the arch code to break that behavior.

That said, I think it may be beneficial to allow a fallback if the
user cares.  So maybe memremap() can call plain ioremap() if
MEMREMAP_STRICT is not set and none of the other mapping types are
satisfied.

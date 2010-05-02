From: jassisinghbrar@gmail.com (jassi brar)
Date: Sun, 2 May 2010 09:23:39 +0900
Subject: [PATCH 1/7] PL330: Add common core driver\
In-Reply-To: <j2he9c3a7c21005011401l7935e674k7a2cf67dfe51b165@mail.gmail.com>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<20100426045420.GH28105@trinity.fluff.org>
	<o2m1b68c6791004252320j40360bc3x849eeeefe25fb49@mail.gmail.com>
	<20100426070924.GH6684@trinity.fluff.org>
	<j2he9c3a7c21005011401l7935e674k7a2cf67dfe51b165@mail.gmail.com>
Message-ID: <p2u1b68c6791005011723g595c30abqe7236b3c4b4f07d9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 2, 2010 at 6:01 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Apr 26, 2010 at 12:09 AM, Ben Dooks <ben-linux@fluff.org> wrote:
>> On Mon, Apr 26, 2010 at 03:20:59PM +0900, jassi brar wrote:
>>> On Mon, Apr 26, 2010 at 1:54 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>>> > On Wed, Apr 21, 2010 at 04:27:28PM +0900, jassisinghbrar at gmail.com wrote:
>>> >> From: Jassi Brar <jassi.brar@samsung.com>
>>> >> + * Mark a _pl330_req as free.
>>> >> + * We do it by writing DMAEND as the first instruction
>>> >> + * because no valid request is going to have DMAEND as
>>> >> + * its first instruction to execute.
>>> >> + */
>>> >> +#define MARK_FREE(req) ? ? ? do { \
>>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? _emit_END(0, (req)->mc_cpu); \
>>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (req)->mc_len = 0; \
>>> >> + ? ? ? ? ? ? ? ? ? ? } while (0)
>>> >
>>> > I think inline functions for these would be easier to read.
>>> you mean alignment that we see here? it's actually correctly
>>> aligned in an editor.
>>
>> firstly, on the grounds it avoids the whole \
>> and secondly on the grounds inline functions get checked by the compiler
>> whether they're used or not.
>
> ...thirdly any macro that evaluates its arguments more than once is
> potentially dangerous for cases like MARK_FREE(req++).
>
>>
>> I belive any macro over a couple of lines is probably doing too much
>> work.
Well, the three points are valid and we might have even more against
using macros _generally_. But just for the sake of clarification/learning..
a) We do have many multi-line macros in the kernel
b) The macro MARK_FREE does two independent things, where as a
    function usually does a sequence of logical steps. The macro
    MARK_FREE is clearly being used in our case.
c) Since the driver uses exactly two requests and we always explicitly
    free req[0] or req[1], I think we are in no danger of referencing invalid
    memory here.
Though having been asked by two maintainers, I will change it to
inline func though.
Thanks.

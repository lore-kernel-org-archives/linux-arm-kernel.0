From: imirkin@alum.mit.edu (Ilia Mirkin)
Date: Wed, 7 Dec 2016 15:08:06 -0500
Subject: [Nouveau] 4.9-rc7 nouveau fails on arm64 64k page kernel but
 works with 4k
In-Reply-To: <CAAVeFuKfo3sZL84wTiR6ur=PVsPhcaU62ggTwy9r1aQEOq2HZw@mail.gmail.com>
References: <042c54f3-e52b-6658-18c7-9c19492485a4@arm.com>
 <CAKb7Uvhewyhnrnd=fw9QrdEDLecG_VMZ8Wfuh-LyCgeW6X_wCw@mail.gmail.com>
 <CAKb7UvgZLafVmC3N0R-dfm4FDtCxUO3fC-4zLwsKauAj=hx=tw@mail.gmail.com>
 <CAKb7UvgW331K53x3wub5o+6LOqeLN5PqgiiJG6WXi+WJDVDzDg@mail.gmail.com>
 <CAAVeFuJc5y8M4Koj-Ge0XpK3PXVS-fnjrpUyD13skeBM1y_K1w@mail.gmail.com>
 <d196c0c8-f429-4275-6246-a4e817b4bdf9@daenzer.net>
 <CAAVeFuKfo3sZL84wTiR6ur=PVsPhcaU62ggTwy9r1aQEOq2HZw@mail.gmail.com>
Message-ID: <CAKb7Uvif+WseKjXKPL_-HCk5MgjKMCUjAk_XYMfoSxrOzqm3Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 4:57 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Wed, Dec 7, 2016 at 6:53 PM, Michel D?nzer <michel@daenzer.net> wrote:
>> On 07/12/16 06:39 PM, Alexandre Courbot wrote:
>>> On Fri, Dec 2, 2016 at 12:23 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>>>> That's right -- nouveau currently requires 4k page sizes to work. This is a
>>>> software limitation, not a hardware one though.
>>>
>>> Looking at the trace I wonder - is the limitation in Nouveau or in TTM?
>>
>> Nouveau. Non-4K page sizes work fine with radeon (and presumably amdgpu).
>
> Thanks for the precision. I will check if Tegra iGPUs are also
> affected by this - if they are then it gives me a good excuse to take
> care of this bug.

For the most part it's confusion in the (nouveau) code as to what's a
gpu page and what's a cpu page (and the shifts involved). There are
some fringe issues that will need to be addressed, like the fact that
it's no longer a 1:1 mapping, which might be assumed in some places.

However I thought that 64K-pages were frowned upon nowadays for the
kernel - outside of HPC loads, most of the kernel memory becomes
pagecache, and files don't tend to be 64K-sized, so you have tons of
wasted memory (since you never cache multiple files in the same page).

But don't take that as me disapproving of such a project. It'd esp be
nice to do something like this outside of the PPC64 environment, where
BE concerns mix in with the 64K page concerns, and nothing works as a
result.

  -ilia

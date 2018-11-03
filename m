From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat, 3 Nov 2018 10:45:03 +0000
Subject: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Message-ID: <20181103104503.eftn5btx7otgufro@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > As mentioned in another part of the thread we can also add robustness
> > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > large comment regarding why). Doing the check directly is abusing
> > internal knowledge that smp.c normally keeps to itself so an accessor
> > of some kind would be needed.
> 
> Sure.  I could add smp_async_func_finished() that just looked like:
> 
> int smp_async_func_finished(call_single_data_t *csd)
> {
>   return !(csd->flags & CSD_FLAG_LOCK);
> }
> 
> My understanding of all the mutual exclusion / memory barrier concepts
> employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> to just access the structure and check the bit directly.
> 
> ...but do you think adding a generic accessor like this is better than
> just keeping track of this in kgdb directly?  I could avoid the
> accessor by adding a "rounding_up" member to "struct
> debuggerinfo_struct" and doing something like this in roundup:
> 
>   /* If it didn't round up last time, don't try again */
>   if (kgdb_info[cpu].rounding_up)
>     continue
> 
>   kgdb_info[cpu].rounding_up = true
>   smp_call_function_single_async(cpu, csd);
> 
> ...and then in kgdb_nmicallback() I could just add:
> 
>   kgdb_info[cpu].rounding_up = false
> 
> In that case we're not adding a generic accessor to smp.c that most
> people should never use.

Whilst it is very tempting to make a sarcastic reply here ("Of course! What
kgdb really needs is yet another set of condition variables") I can't
because I actually agree with the proposal. I don't really want kgdb to
be too "special" especially when it doesn't need to be.

Only thing to note is that rounding_up will not be manipulated within a
common spin lock so you might have to invest a bit of thought to make
sure any races between the master and slave as the slave CPU clears the
flag are benign.


Daniel.

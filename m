From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Nov 2013 09:42:29 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <1432962.yW4lKnaQJE@flatron>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <E1VZjCU-0005RE-Vt@jdl.com> <20131025231106.GC17659@voom.redhat.com>
 <1432962.yW4lKnaQJE@flatron>
Message-ID: <5277CE75.6070804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2013 04:15 PM, Tomasz Figa wrote:
> On Saturday 26 of October 2013 10:11:06 David Gibson wrote:
>> On Fri, Oct 25, 2013 at 10:21:22AM -0500, Jon Loeliger wrote:
>>>> On 10/25/2013 12:43 AM, Grant Likely wrote:
>>>>> On Thu, 24 Oct 2013 22:51:28 +0100, Stephen Warren
>>>>> <swarren@wwwdotorg.org>> > 
>>>> wrote:
>>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>>
>>>>>> This is a very quick proof-of-concept re: how a DT schema checker
>>>>>> might
>>>>>> look if written in C, and integrated into dtc.
>>>>>
>>>>> Thanks for looking at this.
>>>>>
>>>>> Very interesting. Certainly an expedient way to start checking
>>>>> schemas,
>>>>> and for certain bindings it may be the best approach. The downside
>>>>> is it forces a recompilation of DTC to bring in new bindings and
>>>>> it isn't a great meduim for mixing schema with documentation in
>>>>> the bindings.> > 
>>>> This approach would certainly require recompiling something. I threw
>>>> the code into dtc simply because it was the easiest container for
>>>> the demonstration. It could be a separate DT validation utility if
>>>> we wanted, although we'd need to split the DT parser from dtc into
>>>> a library to avoid code duplication. The resultant utility could be
>>>> part of the repo containing the DTs, so it didn't end up as a
>>>> separate package to manage.
>>>>
>>>> I think the additional documentation could be added as comments in
>>>> the
>>>> validation functions, just like IIRC it was to be represented as
>>>> comments even in the .dts-based schema proposals.
>>>
>>> DTers,
>>>
>>> I think the additional benefit of starting with a direct C
>>> implementation is that it causes us to begin to actually
>>> codify the schema requirements.  Sure, it may not be ideal
>>> at first, but over time it may reveal consistent patterns
>>> that can be extracted.  And it may reveal what a real schema
>>> might look like and how it might be expressed better.  Which
>>> is to say that perhaps we are letting "perfect" get in the
>>> way of "good enough to start"?
>>>
>>> In the meantime, someone has shown us the code and we can
>>> get started.  It's a Small Matter of Refactoring later. :-)
>>
>> Yes!  This!
>>
>> Think of this prototype as a mechanism for collating and applying a
>> bunch of schemas to the tree.  At the moment the schemas are all hard
>> coded in C, but it can be extended to load some or all of them
>> dynamically from a description / template / whatever.
>>
>> That also gives us the flexibility to start out with a simple but
>> limited schema language which handles common cases, while leaving the
>> complex cases in C, at least until we understand the requirements well
>> enough to extend the schema language.
> 
> This is fine as an intermediate step, but I'm afraid that the overhead of 
> work needed to describe all the bindings using C language directly will be 
> pretty big. C language isn't really best fitted for such purposes.

My opinion is the exact opposite.

If you create a custom schema language, you have to develop:

* An entire new language specification, and perhaps syntax to represent
the schema.

* A new parser (if not lexer).

* Keep extending that as new schemas require more and more different
validation that wasn't originally considered.

Once we've specified every schema, we'll end up having had to invent a
completely new Turing-complete language.

However, if schemas are simply C code, you simply write code to validate
the data. In my opinion, nothing could be simpler. Everyone working on
the kernel is already familiar with C. We can refactor common patterns
into function calls so people don't have to re-implement it.

I don't see any reason why the C schema checker couldn't be linked into
the kernel and applied at run-time, assuming we take a little care to
write is as a library we call from dtc, rather than something closely
coupled with dtc's internals. (Or implement it as a separate app).

(Note that there's a bit more information in a .dts that a DTB, so some
schema checking might be harder on a DTB). For example, phandle
references are just another cell in the binary, but have a unique syntax
in the source.

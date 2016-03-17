From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 17 Mar 2016 12:52:39 +0900
Subject: [PATCH] kbuild: drop FORCE from PHONY targets
In-Reply-To: <CALCETrW2h+Rt5oEmr09Faf9OesFWYZ_SXmj=zHE4+rDYO85p6Q@mail.gmail.com>
References: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
 <CALCETrVqzidL7SXsCVm8wWrcQMR9dFOLGnDtC-eEYMO4a+yszA@mail.gmail.com>
 <CAK7LNARELkQbhAfBdh9Tx7gVGkpN9gTJzoqJwOF-0CH4zm+wcw@mail.gmail.com>
 <CALCETrVgSUy4ofeBmkZ7TurKvmQVX8C1aj__SLOL6SboQ3S-WA@mail.gmail.com>
 <CAK7LNAQOJjcn7Q+s_pKqzUuojMBtOsRNKsmVwDFXvTeU-zvSeQ@mail.gmail.com>
 <CALCETrU+6sj=reBgPBy7Mq6KYY7BKkVLGwm4XrVzOzb8aU+meg@mail.gmail.com>
 <CAK7LNATAeMmfwWiZha17mbyWhF6bR5RGjv+gbsQTvL4teoTiPQ@mail.gmail.com>
 <CALCETrVNMv5XwpXTJcevVLCfTSMbsqKsjzzukoGr7VAHuumFpg@mail.gmail.com>
 <56E87463.9020300@suse.com>
 <CALCETrW2h+Rt5oEmr09Faf9OesFWYZ_SXmj=zHE4+rDYO85p6Q@mail.gmail.com>
Message-ID: <CAK7LNARQogVrkpGLkmtRJpJQ1zf6m_5yBv0dy+x+_3HF9dyQxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

2016-03-16 5:48 GMT+09:00 Andy Lutomirski <luto@amacapital.net>:
> On Tue, Mar 15, 2016 at 1:45 PM, Michal Marek <mmarek@suse.com> wrote:
>> Dne 15.3.2016 v 19:27 Andy Lutomirski napsal(a):
>>> Fair enough, although I'm curious why this happens.  It might be worth
>>> changing the docs to say that .PHONY is *not* an substitute for FORCE
>>> in that context, then.
>>
>> These two are unrelated, except that FORCE is redundant for a .PHONY
>> target. FORCE is our idiom to tell make to always remake the target and
>> let us handle the dependencies manually. Listing a target as .PHONY
>> tells make that the target will not produce a file of the same name
>> (typically, "all", "install", etc).
>>
>
> Except that apparently if-changed doesn't work on .PHONY targets that
> don't specify FORCE, which confuses me.


OK, I will try to explain it.
I hope this will help you, not confuse you even more...


I think the difference of Kbuild behavior
comes down to "$?" behavior of GNU Make.




Please see the definition of "if_changed".


if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
        @set -e;                                                             \
        $(echo-cmd) $(cmd_$(1));                                             \
        printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd)



The "if_changed" does some actions if "any-prereq" or "arg-check" is non-empty.



Next, let's take a look at the definition of "any-prereq"

any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)



It seems $? makes the difference between FORCE and PHONY.


The GNU Make manual says as follows:
-------------------->8-----------------------------------
$?    The names of all prerequisites that are newer than the target,
      separated by spaces.
--------------------8<-----------------------------------

>From this statement, it is unclear what happens to $? if the target is
a PHONY target.
I am not a GNU Make developer, so I have no idea about the detailed
implementation,
but anyway let's try simple experiments.



[Example 3]

Let's write a simple Makefile as follows.

--------------------->8---------------------
foo: bar FORCE
        echo $$? is "$?"
        cp $< $@

bar:
        touch $@

.PHONY: FORCE
FORCE:
----------------------8<--------------------

yamada at beagle:~/workspace/test$ rm -f foo bar
yamada at beagle:~/workspace/test$ make
touch bar
echo $? is "bar FORCE"
0 is bar FORCE
cp bar foo
yamada at beagle:~/workspace/test$ make
echo $? is ""
0 is
cp bar foo
yamada@beagle:~/workspace/test$ make
echo $? is ""
0 is
cp bar foo


As we expected, $? contains the prerequisite "bar",
but it is empty for the second run or later (because "foo" is newer than "bar").



[Example 4]

Let's replace the FORCE with PHONY.

--------------------->8---------------------
.PHONY: foo
foo: bar
        echo $$? is "$?"
        cp $< $@

bar:
        touch $@
----------------------8<--------------------


yamada at beagle:~/workspace/test2$ rm -f foo bar
yamada at beagle:~/workspace/test2$ make
touch bar
echo $? is "bar"
0 is bar
cp bar foo
yamada at beagle:~/workspace/test2$ make
echo $? is "bar"
0 is bar
cp bar foo
yamada@beagle:~/workspace/test2$ make
echo $? is "bar"
0 is bar
cp bar foo


This time, $? always contains "bar"
nevertheless "foo" is newer than "bar" on the second run or later.


So, it looks like GNU Make assumes that
all the prerequisites of a PHONY target are always newer than the target.



Go back to the definition of "any-prereq",

any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)

If the prerequisite is not a PHONY target  (like the "baz" in the
example 2 in my former email),
it is not filtered out from $?.  So, any-prereq is non-empty and
if_changed updates the target.





-- 
Best Regards
Masahiro Yamada

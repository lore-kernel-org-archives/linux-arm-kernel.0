From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 18 Mar 2014 14:49:12 -0700
Subject: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
In-Reply-To: <20140318180856.GB792@e102568-lin.cambridge.arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
 <20140318180856.GB792@e102568-lin.cambridge.arm.com>
Message-ID: <CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2014 11:08, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > +        * When we reach the max number of CPU idle states or
>> > +        * head_idx == curr_idx (empty nodes queue) we are done.
>> > +        */
>> > +       head_idx = curr_idx = cnt;
>> > +
>> > +       do {
>> > +               curr_idx = parse_idle_states_node(curr, curr_idx, cpus);
>> > +               if (curr_idx == CPUIDLE_STATE_MAX || head_idx == curr_idx)
>> > +                       break;
>> > +               /*
>> > +                * idle_states array is updated by parse_idle_states_node(),
>> > +                * we can use the initialized states as a queue of nodes
>> > +                * that need to be checked for their idle states siblings.
>> > +                * head_idx works as a pointer into the queue to get the
>> > +                * next node to be parsed.
>> > +                */
>> > +               curr = idle_states[head_idx++].node;
>> > +       } while (curr);
>>
>> I still object to index property and this is why. You need to be able
>> to determine state order by actual h/w properties. That is what you
>> are doing in your head when you define the indexes.
>>
>> You really want a linked list here that you can sort as you go and not
>> care what order you parse DT nodes. Not to mention you don't know how
>> many states you will have.
>
> This code does not care about the order of nodes, the index is just there
> to keep track of nodes that have still to be parsed. Sorting is done later,
> using the index property (totally unrelated to the {head/curr}_idx) which I
> understand is frowned upon in DT world (but in this case I think it could be
> accepted, certainly it would make my life easier).
>
> Having said that, I like the idea of implementing it with a linked list and
> sorting states while parsing them. I will remove that index property and
> replace it with an actual hw property: power_consumption ? Or should I just
> use min_residency (the higher the required residency the deeper the idle
> state) ? Defining the power consumption (or better savings) for a state is
> an _outright_ can of worms, that's why using an index is easier.
>
> Thoughts ?

How about something like rank, power_rank or power_score since it's
neither an index nor a physical value but a value for sorting states
relative to each other?

Thanks,

Sebastian

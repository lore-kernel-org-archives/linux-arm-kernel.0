From: dsaxena@linaro.org (Deepak Saxena)
Date: Mon, 19 Sep 2011 16:14:18 -0700
Subject: Sept 14th struct_clk discussion meetings notes
Message-ID: <20110919231418.GA7928@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[Resend with update of l-a-k address in my alias to the correct
 one on infradead].

A group of us met at Linux Plumber's Conf two weeks ago to
discuss struct clk and how we move forward with it. Several
of us had a follow up phone call last week, on Wed the 14th,
and what follows are meeting notes from this follow up 
discussion (I've seem to have lost the notepad on which I 
took notes during the LPC discussion).

Attendees:

Arnd Bergman
Stephen Boyd 
Mark Brown
Thomas Gleixner
Shawn Guo
Saravana Kannan
Nicolas Pitre
Mike Turquette
Linus Walleij
Paul Walmsley

- Mike T.

  - Remove set_parent and upstream clock arbitration
  - Functionality is limited, but would work for OMAP as is
  - We can add new features as needed

- Shawn

  - Does not want to block new SoC support due to common clock 
    support not being ready. This is gating mx6 support being 
    merged upstream.

- Arnd

  - Pre-req: Device Tree representation of struct clk before we
    let these patches in.

  - Mike T: Can we split the problems.

  - Arnd: Yes?

  - Thomas: Is not entirely separate.

    Current patches are not enough to do actual representation of
    building blocks. Need more than just the ops pointer structure.

    Will look into what it would take the current patches and
    then slowly add changes to building block.

- Stephen

  - Want 1 tree lock instead of a framework lock:
   + Have 2 trees, 1 fast (1ms), 1 really slow (5ms)     

  - Thomas: Should be trivial to implement

  - Once the traverse code is fixed, will be hard to change
    the locking code, so need to get this right.
 
  - Thomas: Need a clock tree base with its own lock and put
    a struct clk tree into that tree base.

  - Paul W.: How rate propagation would work across bases?

  - Thomas: Should be doable with proper locking order, and
    should not be too hard to solve. Non fast path.

  - Can implement separate root clocks for right now

  - tglx: separate struct clk from building block devices such
    as frequency management.

- Paul W.

  - Have multiple root clocks, but only one lock right now

  - Figure out the scope of the patches to be.

    Goal: get basic support for common struct clk upstream.

    Get imx6 upstream w/o common struct clk

    Has some bugs and races on existing code.

    set_rate: Can parents be switched at same time?

    operate under set_rate and set_parent as distinct operations.

    clk_rate sample implementation: will only work in some limited
    cases. Need to guarantee that clock is stable. There are lot
    of hw specific that may not be possible to abstract. 
    Not true: "All parents are equal and should be treated the
    same" during set_rate. From tglx: Looked at existing stuff
    and noted that a lot of implementations share concepts...
    walking a freq table or a divisor table. Paul: Agree,
    can go into some sort of library code down the road.

    in-tree vs out-of-tree: what's shipping on most device
    is quite a bit more hacky and complex than what is
    currently in mainline. Will need clock notifiers
    before being able to use on real shipping devices.

    Much code that calls clk_set_rate() assumes that code
    will not be changed in the future.

    Patch 1: good
    Patch 2: needs a bit more thought
    Patch 3: no comments yet

    What do people think about having initial patches to convert
    to using common clk struct but having sub-arch specific 
    set_rate and get_rate? General consensus: seems like a 
    good idea.

- Linus W.:

  No major comments

- Nicolas:

  Just listening in to understand the issues involved.

ACTION ITEMS:

- Thomas: will post updated patches by end of the week

- Others: Will post initial patches porting their platforms
  to new patches as follow up.

- Deepak: Organize follow up call in two weeks and post to wider
  audience to attend.

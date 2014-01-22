From: chenxg.marvell@gmail.com (Xiaoguang Chen)
Date: Wed, 22 Jan 2014 14:02:57 +0800
Subject: mutual exculsion between clk_prepare_enable /clk_disable_unprepare
 and clk_set_parent
Message-ID: <CAFgnuDdOKxzFSDCBQTGw=p_t0CvKfjVEudttOCP_wrzyA2K1Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mike

We met a issue between clk_prepare_enable /clk_disable_unprepare and
clk_set_parent.

As we know, clk preprare/unprare will grab preprare lock, and clk
enable/disable will grab enable lock. clk_set_parent will grab prepare
lock

but there is no lock protection in clk_prepare_enable /clk_disable_unprepare,
for example, in clk_disable_unprepare, it is expended as clk_disable +
clk_unprepare,

and if below condition occurs, there will be problem
thread1                                                 thread 2
call clk_disable_unprepare
1) clk_disable
get enable lock
...............
release enable lock

                                                     call clk_set_parent
                                                     get prepare lock
                                                     set clock's
parent to another parent
                                                     release prepare lock

2) clk_unprepare
get prepare lock
unprepare parent clock <<--------------
release prepare lock

In above sequence, After thread 1 call clock disable, thread 2 change
clk's parent to another clock, then in thread1 step2, it will
unprepare clk's new parent, but not old parent, this will cause old
parent is not unprepared, but new parent is unprepared even when it is
not prepared yet.

So How can we use this API: clk_prepare_enable and clk_disable_unprepare  ?
Should we add lock to protect this API, if we get a prepare lock
inside this API, like
clk_disable_unprepare ()
{
get_prepare_lock();
clk_disable();
clk_unprepare();
clk_prepare_unlock();
}

is above sequence ok? if so, I can provide a patch for this.

Thanks
Xiaoguang

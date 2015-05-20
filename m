From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 20 May 2015 09:11:37 +0530
Subject: [PATCH V5 0/3] OPP: Introduce OPP (V2) bindings
Message-ID: <cover.1432091956.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Finally V4 got some good review comments, Acks, etc.. I have updated the
bindings with all review comments and here is V5.

V4->V5:
- opp-microamp fixed and rewritten as per Mark's suggestions.
- shared-opp renamed as opp-shared, as that's the convention for other
  properties.
- Dropped "[V4 3/3] OPP: Add 'opp-next' in operating-points-v2 bindings" as that
  was NAK'd by Mike T..
- Added [V5 3/3] based on Nishanth's suggestions.
- Added an example for 2/3, multiple OPP nodes.
  @Stephen/Nishanth: I have kept your tags here as I haven't changed the binding
  but only an example. Please let me know if you have some comments.

- Other minor formatting..
- Existing binding: "operating-points" isn't deprecated now as platforms looking
  for simple bindings should be allowed to use them.
- opp-khz is changed to opp-hz, examples updated.
- turbo-mode explained


V3->V4:
- Dropped code changes as we are still concerned about bindings.
- separated out into three patches, some of which might be NAK'd. :)
- The first patch presents basic OPP stuff that was reviewed earlier. It also
  has support for multiple regulators, with values for both current and voltage.
- Second patch is based on a special concern that Stephen had about multiple OPP
  tables, one of which the parsing code will select at runtime.
- Third one separates out 'opp-next' or Intermediate freq support as Mike T. had
  few concerns over it. He wanted the clock driver to take care of this and so
  do not want it to be passed by DT and used by cpufreq. Also, there were
  concerns like the platform may not want to choose intermediate frequency as a
  target frequency for longer runs, which wasn't prevented in earlier bindings.
  And so it is kept separate to be NAK'd quietly, without much disturbances.

  ---------------x-------------------x------------------------

Current OPP (Operating performance point) DT bindings are proven to be
insufficient at multiple instances.

The shortcomings we are trying to solve here:

- Getting clock/voltage/current rails sharing information between CPUs.
  Shared by all cores vs independent clock per core vs shared clock per
  cluster.

- Support for specifying current levels along with voltages.

- Support for multiple regulators.

- Support for turbo modes.

- Other per OPP settings: transition latencies, disabled status, etc.?

- Expandability of OPPs in future.

This patchset tries to solve these shortcomings with a new "operating-points-v2"
binding, which can be easily extended later if required.

Viresh Kumar (3):
  OPP: Redefine bindings to overcome shortcomings
  OPP: Allow multiple OPP tables to be passed via DT
  OPP: Add binding for 'opp-suspend'

 Documentation/devicetree/bindings/power/opp.txt | 437 +++++++++++++++++++++++-
 1 file changed, 433 insertions(+), 4 deletions(-)

-- 
2.4.0

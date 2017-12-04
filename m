From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 16:25:28 -0600
Subject: [PATCH V5 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <590f0536-b73d-ee32-a284-32e564af2f57@codeaurora.org>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
 <1512188864-773-5-git-send-email-okaya@codeaurora.org>
 <CAL_JsqJ+fMqrt6Tk8h6v1fSkrBg+GcMxSXK9XCcz3nmYgyguuQ@mail.gmail.com>
 <590f0536-b73d-ee32-a284-32e564af2f57@codeaurora.org>
Message-ID: <20171204222528.wf6xpozisxu5udx5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 01:05:51PM -0500, Sinan Kaya wrote:
> On 12/4/2017 11:23 AM, Rob Herring wrote:
> > On Fri, Dec 1, 2017 at 10:27 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> >> Now that we have a get_match_data() callback as part of the firmware node,
> >> implement the OF specific piece for it.
> >>
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >> ---
> >>  drivers/of/property.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> ..
> 
> >>
> >> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
> >> +                              const struct device_driver *drv)
> >> +{
> >> +       const struct device_node *node = to_of_node(fwnode);
> >> +       const struct of_device_id *match;
> >> +
> >> +       if (!node)
> >> +               return NULL;
> > 
> > of_match_node checks this.
> 
> I see a check for the matches argument but not for the node argument.
> Am I missing something?

Ah yes, you are right.

> 
> > 
> >> +
> >> +       match = of_match_node(drv->of_match_table, node);
> >> +       if (!match)
> >> +               return NULL;
> >> +
> >> +       return (void *)match->data;
> > 
> > Don't need a cast here.
> 
> I can fix this.
> 
> > 
> > of_device_get_match_data() already does most of this, but getting a
> > device ptr from fwnode_handle may not be possible?
> 
> I couldn't figure out how to do that. Do you have a suggestion?
> I have been looking for examples with no luck.

Change the property API to pass struct device instead. That's maybe not 
worth it.

Rob

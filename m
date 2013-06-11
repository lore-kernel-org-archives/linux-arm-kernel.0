From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 11 Jun 2013 22:51:47 +0100
Subject: [PATCH] of: Add missing node iteration stubs for disabled
 CONFIG_OF
In-Reply-To: <51B74EDF.2090504@arm.com>
References: <1362860154-3089-1-git-send-email-tomasz.figa@gmail.com>
 <5159F9E6.50508@gmail.com> <51B74EDF.2090504@arm.com>
Message-ID: <20130611215147.199B13E0D8D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 17:22:55 +0100, Jonathan Austin <jonathan.austin@arm.com> wrote:
> Hi Rob, Thomasz,
> 
> (dredging up an oldish thread as I just ran in to this issue)
> 
> On 01/04/13 22:19, Rob Herring wrote:
> > On 03/09/2013 02:15 PM, Tomasz Figa wrote:
> >> This patch moves several for_each macros out of the #ifdef CONFIG_OF
> >> block and adds inline stubs for functions used by these macros, compiled
> >> conditionally when CONFIG_OF is not enabled.
> >>
> >> This eliminates the need to explicitly check for CONFIG_OF in driver
> >> code using mentioned functions and macros.
> > 
> > Do you have some users of this?
> 
> I do!
> 
> Or at least I might.
> 
> I'm not certain as perhaps the fix to what I describe below is to add
> dependencies on CONFIG_OF - it isn't clear to me either way:
> 
> With both psci and arch_timers (CONFIG_ARM_PSCI, CONFIG_ARM_ARCH_TIMER)
> and without CONFIG_OF we get a build failure because we lack the definition
> of of_find_matching_node():
> 
> eg:
> arch/arm/kernel/psci.c:167:2: error: implicit declaration of function ???of_find_matching_node??? [-Werror=implicit-function-declaration]
> 
> The same happens with arm_arch_timer.c (well, there's a patch required to
> include linux/of.h first, after which Thomasz's patch is relevant).

That code path is completely broken if CONFIG_OF is not set. psci_init()
is nothing but calls to CONFIG_OF infrastructure! I think that code
needs to depend on CONFIG_OF, or at least be wrapped with
"if (IS_ENABLED(CONFIG_OF))" if there are still usable parts when
CONFIG_OF is disabled. Frankly I don't see that as being a real concern.

That said, Arnd has posted a patch that moves at least some of the function
prototypes out from under the #ifdef block so that GCC can do syntax
checking on disabled code. That overlaps a bit with this patch.

Regardless, I'm not going to apply it without a legitimate (as opposed
to theoretical) user.

g.

> So, I guess the question is whether we should expect PSCI and ARM_ARCH_TIMER
> to depend on CONFIG_OF, or whether we'd like them to fail gracefully in the
> case that we *don't* have CONFIG_OF. I think the current situation is broken
> either way...
> 
> Thoughts?
> 
> Jonny
> 
> > 
> > Rob
> > 
> >>
> >> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> >> ---
> >>   include/linux/of.h | 92 +++++++++++++++++++++++++++++++++++++-----------------
> >>   1 file changed, 63 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/include/linux/of.h b/include/linux/of.h
> >> index a0f1292..7a736b8 100644
> >> --- a/include/linux/of.h
> >> +++ b/include/linux/of.h
> >> @@ -86,6 +86,31 @@ static inline struct device_node *of_node_get(struct device_node *node)
> >>   static inline void of_node_put(struct device_node *node) { }
> >>   #endif /* !CONFIG_OF_DYNAMIC */
> >>
> >> +#define for_each_node_by_name(dn, name) \
> >> +     for (dn = of_find_node_by_name(NULL, name); dn; \
> >> +          dn = of_find_node_by_name(dn, name))
> >> +#define for_each_node_by_type(dn, type) \
> >> +     for (dn = of_find_node_by_type(NULL, type); dn; \
> >> +          dn = of_find_node_by_type(dn, type))
> >> +#define for_each_compatible_node(dn, type, compatible) \
> >> +     for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
> >> +          dn = of_find_compatible_node(dn, type, compatible))
> >> +#define for_each_matching_node(dn, matches) \
> >> +     for (dn = of_find_matching_node(NULL, matches); dn; \
> >> +          dn = of_find_matching_node(dn, matches))
> >> +#define for_each_matching_node_and_match(dn, matches, match) \
> >> +     for (dn = of_find_matching_node_and_match(NULL, matches, match); \
> >> +          dn; dn = of_find_matching_node_and_match(dn, matches, match))
> >> +#define for_each_child_of_node(parent, child) \
> >> +     for (child = of_get_next_child(parent, NULL); child != NULL; \
> >> +          child = of_get_next_child(parent, child))
> >> +#define for_each_available_child_of_node(parent, child) \
> >> +     for (child = of_get_next_available_child(parent, NULL); child != NULL; \
> >> +          child = of_get_next_available_child(parent, child))
> >> +#define for_each_node_with_property(dn, prop_name) \
> >> +     for (dn = of_find_node_with_property(NULL, prop_name); dn; \
> >> +          dn = of_find_node_with_property(dn, prop_name))
> >> +
> >>   #ifdef CONFIG_OF
> >>
> >>   /* Pointer for first entry in chain of all nodes. */
> >> @@ -167,19 +192,10 @@ static inline const char *of_node_full_name(const struct device_node *np)
> >>
> >>   extern struct device_node *of_find_node_by_name(struct device_node *from,
> >>        const char *name);
> >> -#define for_each_node_by_name(dn, name) \
> >> -     for (dn = of_find_node_by_name(NULL, name); dn; \
> >> -          dn = of_find_node_by_name(dn, name))
> >>   extern struct device_node *of_find_node_by_type(struct device_node *from,
> >>        const char *type);
> >> -#define for_each_node_by_type(dn, type) \
> >> -     for (dn = of_find_node_by_type(NULL, type); dn; \
> >> -          dn = of_find_node_by_type(dn, type))
> >>   extern struct device_node *of_find_compatible_node(struct device_node *from,
> >>        const char *type, const char *compat);
> >> -#define for_each_compatible_node(dn, type, compatible) \
> >> -     for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
> >> -          dn = of_find_compatible_node(dn, type, compatible))
> >>   extern struct device_node *of_find_matching_node_and_match(
> >>        struct device_node *from,
> >>        const struct of_device_id *matches,
> >> @@ -190,12 +206,6 @@ static inline struct device_node *of_find_matching_node(
> >>   {
> >>        return of_find_matching_node_and_match(from, matches, NULL);
> >>   }
> >> -#define for_each_matching_node(dn, matches) \
> >> -     for (dn = of_find_matching_node(NULL, matches); dn; \
> >> -          dn = of_find_matching_node(dn, matches))
> >> -#define for_each_matching_node_and_match(dn, matches, match) \
> >> -     for (dn = of_find_matching_node_and_match(NULL, matches, match); \
> >> -          dn; dn = of_find_matching_node_and_match(dn, matches, match))
> >>   extern struct device_node *of_find_node_by_path(const char *path);
> >>   extern struct device_node *of_find_node_by_phandle(phandle handle);
> >>   extern struct device_node *of_get_parent(const struct device_node *node);
> >> @@ -207,14 +217,6 @@ extern struct device_node *of_get_next_available_child(
> >>
> >>   extern struct device_node *of_get_child_by_name(const struct device_node *node,
> >>                                        const char *name);
> >> -#define for_each_child_of_node(parent, child) \
> >> -     for (child = of_get_next_child(parent, NULL); child != NULL; \
> >> -          child = of_get_next_child(parent, child))
> >> -
> >> -#define for_each_available_child_of_node(parent, child) \
> >> -     for (child = of_get_next_available_child(parent, NULL); child != NULL; \
> >> -          child = of_get_next_available_child(parent, child))
> >> -
> >>   static inline int of_get_child_count(const struct device_node *np)
> >>   {
> >>        struct device_node *child;
> >> @@ -228,10 +230,6 @@ static inline int of_get_child_count(const struct device_node *np)
> >>
> >>   extern struct device_node *of_find_node_with_property(
> >>        struct device_node *from, const char *prop_name);
> >> -#define for_each_node_with_property(dn, prop_name) \
> >> -     for (dn = of_find_node_with_property(NULL, prop_name); dn; \
> >> -          dn = of_find_node_with_property(dn, prop_name))
> >> -
> >>   extern struct property *of_find_property(const struct device_node *np,
> >>                                         const char *name,
> >>                                         int *lenp);
> >> @@ -353,13 +351,28 @@ static inline struct device_node *of_find_node_by_name(struct device_node *from,
> >>        return NULL;
> >>   }
> >>
> >> +static inline struct device_node *of_find_node_by_type(struct device_node *from,
> >> +     const char *type)
> >> +{
> >> +     return NULL;
> >> +}
> >> +
> >>   static inline bool of_have_populated_dt(void)
> >>   {
> >>        return false;
> >>   }
> >>
> >> -#define for_each_child_of_node(parent, child) \
> >> -     while (0)
> >> +static inline struct device_node *of_get_next_child(const struct device_node *node,
> >> +                                          struct device_node *prev)
> >> +{
> >> +     return NULL;
> >> +}
> >> +
> >> +static inline struct device_node *of_get_next_available_child(
> >> +     const struct device_node *node, struct device_node *prev)
> >> +{
> >> +     return NULL;
> >> +}
> >>
> >>   static inline struct device_node *of_get_child_by_name(
> >>                                        const struct device_node *node,
> >> @@ -373,6 +386,12 @@ static inline int of_get_child_count(const struct device_node *np)
> >>        return 0;
> >>   }
> >>
> >> +static inline struct device_node *of_find_node_with_property(
> >> +     struct device_node *from, const char *prop_name)
> >> +{
> >> +     return NULL;
> >> +}
> >> +
> >>   static inline int of_device_is_compatible(const struct device_node *device,
> >>                                          const char *name)
> >>   {
> >> @@ -394,6 +413,21 @@ static inline struct device_node *of_find_compatible_node(
> >>        return NULL;
> >>   }
> >>
> >> +static inline struct device_node *of_find_matching_node_and_match(
> >> +     struct device_node *from,
> >> +     const struct of_device_id *matches,
> >> +     const struct of_device_id **match)
> >> +{
> >> +     return NULL;
> >> +}
> >> +
> >> +static inline struct device_node *of_find_matching_node(
> >> +     struct device_node *from,
> >> +     const struct of_device_id *matches)
> >> +{
> >> +     return NULL;
> >> +}
> >> +
> >>   static inline int of_property_read_u8_array(const struct device_node *np,
> >>                        const char *propname, u8 *out_values, size_t sz)
> >>   {
> >>
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
